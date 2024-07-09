import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/data/repositories/firebase_store/firestore_song_lyrics_repository.dart';
import 'package:share_lyrics/presentation/shared_lyrics_details/constants/shared_lyrics_details_state_status.dart';

part 'shared_lyrics_details_event.dart';
part 'shared_lyrics_details_state.dart';

class SharedLyricsDetailsBloc extends Bloc<SharedLyricsDetailsEvent, SharedLyricsDetailsState> {
  SharedLyricsDetailsBloc({
    required SharedLyrics sharedLyrics,
    required FirestoreSongLyricsRepository firestoreSongLyricsRepository,
  })  : _firestoreSongLyricsRepository = firestoreSongLyricsRepository,
        super(SharedLyricsDetailsState(sharedLyrics: sharedLyrics)) {
    on<DeleteSharedLyrics>(_onDeleteSharedLyrics);
    on<ChangeVisibilityOfTitleInAppBar>(_onChangeVisibilityOfTitleInAppBar);
  }

  final FirestoreSongLyricsRepository _firestoreSongLyricsRepository;

  Future<void> _onDeleteSharedLyrics(DeleteSharedLyrics event, Emitter<SharedLyricsDetailsState> emit) async {
    emit(state.copyWith(status: SharedLyricsDetailsStateStatus.deletingSharedLyrics));
    try {
      final sharedLyrics = state.sharedLyrics;
      await _firestoreSongLyricsRepository.deleteSongLyrics(sharedLyrics: sharedLyrics);
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
