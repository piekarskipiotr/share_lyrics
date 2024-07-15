import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/data/repositories/firebase_store/firestore_song_lyrics_repository.dart';
import 'package:share_lyrics/presentation/feed/constants/feed_state_status.dart';
import 'package:share_lyrics/services/auth_service/auth_service.dart';
import 'package:share_lyrics/services/feed_service/feed_service.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  FeedBloc({
    required AuthService authService,
    required FeedService feedService,
    required FirestoreSongLyricsRepository firestoreSongLyricsRepository,
  })  : _authService = authService,
        _feedService = feedService,
        _firestoreSongLyricsRepository = firestoreSongLyricsRepository,
        super(const FeedState()) {
    on<FetchSongLyrics>(_onFetchSongLyrics);
    on<RefreshResults>(_onRefreshResults);

    _refreshSubscription = _feedService.onRefresh.listen((_) {
      add(const RefreshResults());
    });
  }

  final AuthService _authService;
  final FeedService _feedService;
  final FirestoreSongLyricsRepository _firestoreSongLyricsRepository;
  late StreamSubscription<void> _refreshSubscription;

  Future<void> _onFetchSongLyrics(FetchSongLyrics event, Emitter<FeedState> emit) async {
    final page = event.page;
    emit(state.copyWith(status: FeedStateStatus.loadingResults, page: page));
    final userUUID = _authService.currentUser?.uid;
    if (userUUID == null) {
      emit(state.copyWith(status: FeedStateStatus.loadingResultsFailed));
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
      emit(state.copyWith(status: FeedStateStatus.loadingResultsSucceeded, results: results, lastDocSnap: lastDocSnap));
    }).catchError((Object error, StackTrace stacktrace) async {
      log('FAILED FETCH USER SAVED SONG LYRICS, error: $error \n\n $stacktrace');
      emit(state.copyWith(status: FeedStateStatus.loadingResultsFailed, error: error.toString()));
    });
  }

  Future<void> _onRefreshResults(RefreshResults event, Emitter<FeedState> emit) async {
    emit(state.copyWith(status: FeedStateStatus.refreshing, results: []));
    emit(state.copyWith(status: FeedStateStatus.refreshingCompleted));
  }

  @override
  Future<void> close() {
    _refreshSubscription.cancel();
    return super.close();
  }
}
