import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/data/repositories/firebase_store/firestore_song_lyrics_repository.dart';
import 'package:share_lyrics/services/auth_service/auth_service.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc({
    required AuthService authService,
    required FirestoreSongLyricsRepository firestoreSongLyricsRepository,
  })  : _authService = authService,
        _firestoreSongLyricsRepository = firestoreSongLyricsRepository,
        super(const FeedState()) {
    on<FetchSongLyrics>(_onFetchSongLyrics);
  }

  final AuthService _authService;
  final FirestoreSongLyricsRepository _firestoreSongLyricsRepository;

  Future<void> _onFetchSongLyrics(FetchSongLyrics event, Emitter<FeedState> emit) async {
    final page = event.page;
    emit(state.copyWith(status: StateStatus.loading, page: page));
    final userUUID = _authService.currentUser?.uid;
    if (userUUID == null) {
      emit(state.copyWith(status: StateStatus.failure));
      await _authService.signOut();
      return;
    }

    final pageSize = state.pageSize;
    if (page == 1) emit(state.clearLastDocSnapshot());

    final lastDocSnap = state.lastDocSnap;
    await _firestoreSongLyricsRepository
        .fetchSongLyrics(lastDocSnap: lastDocSnap, pageSize: pageSize, userUUID: userUUID)
        .then((snapshot) async {
      final results = snapshot.$1;
      final lastDocSnap = snapshot.$2;
      emit(state.copyWith(status: StateStatus.success, results: results, lastDocSnap: lastDocSnap));
    }).catchError((Object error, StackTrace stacktrace) async {
      log('GENIUS: FAILED FETCH USER SAVED SONG LYRICS, error: $error \n\n $stacktrace');
      emit(state.copyWith(status: StateStatus.failure, error: error.toString()));
    });
  }
}
