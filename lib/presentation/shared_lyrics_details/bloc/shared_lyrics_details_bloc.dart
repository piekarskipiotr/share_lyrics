import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/data/repositories/firebase_store/firestore_song_lyrics_repository.dart';
import 'package:share_lyrics/presentation/shared_lyrics_details/constants/shared_lyrics_details_state_status.dart';
import 'package:share_lyrics/services/feed_service/feed_service.dart';

part 'shared_lyrics_details_event.dart';
part 'shared_lyrics_details_state.dart';

class SharedLyricsDetailsBloc extends Bloc<SharedLyricsDetailsEvent, SharedLyricsDetailsState> {
  SharedLyricsDetailsBloc({
    required SharedLyrics sharedLyrics,
    required FeedService feedService,
    required FirestoreSongLyricsRepository firestoreSongLyricsRepository,
  })  : _feedService = feedService,_firestoreSongLyricsRepository = firestoreSongLyricsRepository,
        super(SharedLyricsDetailsState(sharedLyrics: sharedLyrics)) {
    on<DeleteSharedLyrics>(_onDeleteSharedLyrics);
    on<ChangeVisibilityOfTitleInAppBar>(_onChangeVisibilityOfTitleInAppBar);
  }

  final FeedService _feedService;
  final FirestoreSongLyricsRepository _firestoreSongLyricsRepository;

  Future<void> _onDeleteSharedLyrics(DeleteSharedLyrics event, Emitter<SharedLyricsDetailsState> emit) async {
    emit(state.copyWith(status: SharedLyricsDetailsStateStatus.deletingSharedLyrics));
    try {
      final sharedLyrics = state.sharedLyrics;
      await _firestoreSongLyricsRepository.deleteSongLyrics(sharedLyrics: sharedLyrics);
      _feedService.refresh();
      emit(state.copyWith(status: SharedLyricsDetailsStateStatus.deletingSharedLyricsSucceeded));
    } catch (error, stacktrace) {
      log('FAILED TO DELETE SAVED SHARED LYRICS, error: $error \n\n $stacktrace');
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
