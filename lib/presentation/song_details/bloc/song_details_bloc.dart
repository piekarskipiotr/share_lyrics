import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/data/models/song/song.dart';
import 'package:share_lyrics/data/repositories/genius_repository/genius_repository.dart';

part 'song_details_event.dart';
part 'song_details_state.dart';

class SongDetailsBloc extends Bloc<SongDetailsEvent, SongDetailsState> {
  SongDetailsBloc({required Song song, required GeniusRepository geniusRepository})
      : _geniusRepository = geniusRepository,
        super(SongDetailsState(song: song)) {
    on<FetchSongDetails>(_onFetchSongDetails);
    on<FetchLyrics>(_onFetchLyrics);
  }

  final GeniusRepository _geniusRepository;

  Future<void> _onFetchSongDetails(FetchSongDetails event, Emitter<SongDetailsState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));
    await _geniusRepository.getSongDetails(id: state.song.id).then((song) async {
      emit(state.copyWith(status: StateStatus.success, song: song));
    }).catchError((Object error, StackTrace stacktrace) async {
      log('GENIUS: FAILED TO FETCH SONG DETAILS, error: $error \n\n $stacktrace');
      emit(state.copyWith(status: StateStatus.failure, error: error.toString()));
    });
  }

  Future<void> _onFetchLyrics(FetchLyrics event, Emitter<SongDetailsState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));
    final url = state.song.lyricsUrl;
    if (url == null || url.isEmpty) {
      emit(state.copyWith(status: StateStatus.initial));
      return;
    }

    await _geniusRepository.getSongLyrics(url: url).then((lyrics) async {
      emit(state.copyWith(status: StateStatus.success, lyrics: lyrics));
    }).catchError((Object error, StackTrace stacktrace) async {
      log('GENIUS: FAILED TO FETCH SONG LYRICS, error: $error \n\n $stacktrace');
      emit(state.copyWith(status: StateStatus.failure, error: error.toString()));
    });
  }
}
