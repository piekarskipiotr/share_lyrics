import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_lyrics/data/models/song/song.dart';
import 'package:share_lyrics/data/repositories/genius_repository/genius_repository.dart';
import 'package:share_lyrics/presentation/song_details/constants/song_details_state_status.dart';

part 'song_details_event.dart';
part 'song_details_state.dart';

class SongDetailsBloc extends Bloc<SongDetailsEvent, SongDetailsState> {
  SongDetailsBloc({required Song song, required GeniusRepository geniusRepository})
      : _geniusRepository = geniusRepository,
        super(SongDetailsState(song: song)) {
    on<FetchSongDetails>(_onFetchSongDetails);
    on<FetchLyrics>(_onFetchLyrics);

    add(FetchSongDetails(id: song.id));
  }

  final GeniusRepository _geniusRepository;

  Future<void> _onFetchSongDetails(FetchSongDetails event, Emitter<SongDetailsState> emit) async {
    emit(state.copyWith(status: SongDetailsStateStatus.fetchingSongDetails));
    await _geniusRepository.getSongDetails(id: state.song.id).then((song) async {
      emit(state.copyWith(status: SongDetailsStateStatus.fetchingSongDetailsSucceeded, song: song));
    }).catchError((Object error, StackTrace stacktrace) async {
      log('GENIUS: FAILED TO FETCH SONG DETAILS, error: $error \n\n $stacktrace');
      emit(state.copyWith(status: SongDetailsStateStatus.fetchingSongDetailsFailed, error: error.toString()));
    });
  }

  Future<void> _onFetchLyrics(FetchLyrics event, Emitter<SongDetailsState> emit) async {
    emit(state.copyWith(status: SongDetailsStateStatus.fetchingLyrics));
    final url = state.song.lyricsUrl;
    if (url == null || url.isEmpty) {
      emit(state.copyWith(status: SongDetailsStateStatus.fetchingLyricsFailed));
      return;
    }

    await _geniusRepository.getSongLyrics(url: url).then((lyrics) async {
      emit(state.copyWith(status: SongDetailsStateStatus.fetchingLyricsSucceeded, lyrics: lyrics));
    }).catchError((Object error, StackTrace stacktrace) async {
      log('GENIUS: FAILED TO FETCH SONG LYRICS, error: $error \n\n $stacktrace');
      emit(state.copyWith(status: SongDetailsStateStatus.fetchingLyricsFailed, error: error.toString()));
    });
  }
}
