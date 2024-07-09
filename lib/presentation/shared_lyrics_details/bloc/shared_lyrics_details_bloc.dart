import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/data/repositories/firebase_store/firestore_song_lyrics_repository.dart';
import 'package:share_lyrics/data/repositories/genius_repository/genius_repository.dart';
import 'package:share_lyrics/presentation/shared_lyrics_details/constants/shared_lyrics_details_state_status.dart';

part 'shared_lyrics_details_event.dart';
part 'shared_lyrics_details_state.dart';

class SharedLyricsDetailsBloc extends Bloc<SharedLyricsDetailsEvent, SharedLyricsDetailsState> {
  SharedLyricsDetailsBloc({
    required ShareSongLyrics shareSongLyrics,
    required GeniusRepository geniusRepository,
    required FirestoreSongLyricsRepository firestoreSongLyricsRepository,
  })  : _geniusRepository = geniusRepository,
        _firestoreSongLyricsRepository = firestoreSongLyricsRepository,
        super(SharedLyricsDetailsState(shareSongLyrics: shareSongLyrics)) {
    on<FetchSongData>(_onFetchSongData);
    on<DeleteSharedLyrics>(_onDeleteSharedLyrics);
    on<ChangeVisibilityOfTitleInAppBar>(_onChangeVisibilityOfTitleInAppBar);
    add(const FetchSongData());
  }

  final GeniusRepository _geniusRepository;
  final FirestoreSongLyricsRepository _firestoreSongLyricsRepository;

  Future<void> _onFetchSongData(FetchSongData event, Emitter<SharedLyricsDetailsState> emit) async {
    emit(state.copyWith(status: SharedLyricsDetailsStateStatus.fetchingSongData));
    try {
      final songId = state.shareSongLyrics.id;
      final song = await _geniusRepository.getSongDetails(id: songId);
      emit(state.copyWith(status: SharedLyricsDetailsStateStatus.fetchingSongDataSucceeded, songMedia: song.media));
    } catch (error, stacktrace) {
      log('FAILED TO FETCH SONG DATA, error: $error \n\n $stacktrace');
      emit(state.copyWith(status: SharedLyricsDetailsStateStatus.fetchingSongDataFailed, error: error.toString()));
    }
  }

  Future<void> _onDeleteSharedLyrics(DeleteSharedLyrics event, Emitter<SharedLyricsDetailsState> emit) async {
    emit(state.copyWith(status: SharedLyricsDetailsStateStatus.deletingSharedLyrics));
    try {
      final shareSongLyrics = state.shareSongLyrics;
      await _firestoreSongLyricsRepository.deleteSongLyrics(shareSongLyrics: shareSongLyrics);
      emit(state.copyWith(status: SharedLyricsDetailsStateStatus.deletingSharedLyricsSucceeded));
    } catch (error, stacktrace) {
      log('FAILED TO FETCH SONG DATA, error: $error \n\n $stacktrace');
      emit(state.copyWith(status: SharedLyricsDetailsStateStatus.deletingSharedLyricsFailed, error: error.toString()));
    }
  }

  Future<void> _onChangeVisibilityOfTitleInAppBar(
    ChangeVisibilityOfTitleInAppBar event,
    Emitter<SharedLyricsDetailsState> emit,
  ) async {
    emit(state.copyWith(showTitleInAppBar: event.showTitleInAppBar));
  }
}
