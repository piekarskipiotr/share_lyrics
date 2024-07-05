import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/data/repositories/genius_repository/genius_repository.dart';
import 'package:share_lyrics/presentation/song_details/constants/song_details_state_status.dart';

part 'song_details_event.dart';
part 'song_details_state.dart';

class SongDetailsBloc extends Bloc<SongDetailsEvent, SongDetailsState> {
  SongDetailsBloc({required Song song, required GeniusRepository geniusRepository})
      : _geniusRepository = geniusRepository,
        super(SongDetailsState(song: song)) {
    on<FetchSongData>(_onFetchSongData);
    on<SelectLine>(_onSelectLine);
    on<ChangeVisibilityOfTitleInAppBar>(_onChangeVisibilityOfTitleInAppBar);

    add(const FetchSongData());
  }

  final GeniusRepository _geniusRepository;

  Future<void> _onFetchSongData(FetchSongData event, Emitter<SongDetailsState> emit) async {
    emit(state.copyWith(status: SongDetailsStateStatus.fetchingSongData));
    try {
      final songId = state.song.id;
      final song = await _geniusRepository.getSongDetails(id: songId);
      final url = state.song.lyricsUrl;
      final stringLyrics = (url != null && url.isNotEmpty) ? await _geniusRepository.getSongLyrics(url: url) : null;
      final lyrics = _mapStringTableToLyrics(stringLyrics ?? []);
      emit(state.copyWith(status: SongDetailsStateStatus.fetchingSongDataSucceeded, song: song, lyrics: lyrics));
    } catch (error, stacktrace) {
      log('FAILED TO FETCH SONG DATA, error: $error \n\n $stacktrace');
      emit(state.copyWith(status: SongDetailsStateStatus.fetchingSongDataFailed, error: error.toString()));
    }
  }

  List<Lyric> _mapStringTableToLyrics(List<String> lyrics) {
    return lyrics.map((line) => Lyric(line: line)).toList();
  }

  Future<void> _onSelectLine(SelectLine event, Emitter<SongDetailsState> emit) async {
    emit(state.copyWith(status: SongDetailsStateStatus.selectingLine));
    var lyrics = [...?state.lyrics];
    final selectedIndex = lyrics.indexOf(event.lyric);
    final selectedLyric = lyrics[selectedIndex];
    final isAlreadySelected = selectedLyric.isSelected;
    if (isAlreadySelected) {
      lyrics[selectedIndex] = selectedLyric.copyWith(isSelected: false);
    } else {
      final selectedLyrics = lyrics.where((lyric) => lyric.isSelected).toList();
      final isAdjacentSelection = selectedLyrics.isEmpty ||
          selectedLyrics.any((lyric) {
            final index = lyrics.indexOf(lyric);
            return index == selectedIndex - 1 || index == selectedIndex + 1;
          });

      if (isAdjacentSelection && selectedLyrics.length < 2) {
        lyrics[selectedIndex] = selectedLyric.copyWith(isSelected: true);
      } else {
        lyrics = lyrics
            .map((lyric) => lyric.copyWith(isSelected: false, isNextLineSelected: false, isPreviousLineSelected: false))
            .toList();
        lyrics[selectedIndex] = selectedLyric.copyWith(isSelected: true);
      }
    }

    lyrics = lyrics.map((lyric) => lyric.copyWith(isNextLineSelected: false, isPreviousLineSelected: false)).toList();
    for (var i = 0; i < lyrics.length; i++) {
      if (lyrics[i].isSelected) {
        if (i > 0) lyrics[i - 1] = lyrics[i - 1].copyWith(isNextLineSelected: true);
        if (i < lyrics.length - 1) lyrics[i + 1] = lyrics[i + 1].copyWith(isPreviousLineSelected: true);
      }
    }

    emit(state.copyWith(lyrics: lyrics, status: SongDetailsStateStatus.selectingLineCompleted));
  }

  Future<void> _onChangeVisibilityOfTitleInAppBar(
    ChangeVisibilityOfTitleInAppBar event,
    Emitter<SongDetailsState> emit,
  ) async {
    emit(state.copyWith(showTitleInAppBar: event.showTitleInAppBar));
  }
}
