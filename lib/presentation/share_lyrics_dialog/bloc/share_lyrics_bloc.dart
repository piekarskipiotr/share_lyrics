import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/data/repositories/firebase_store/firestore_song_lyrics_repository.dart';
import 'package:share_lyrics/presentation/share_lyrics_dialog/constants/share_lyrics_state_status.dart';
import 'package:share_lyrics/services/auth_service/auth_service.dart';
import 'package:share_plus/share_plus.dart';

part 'share_lyrics_event.dart';
part 'share_lyrics_state.dart';

class ShareLyricsBloc extends Bloc<ShareLyricsEvent, ShareLyricsState> {
  ShareLyricsBloc({
    required ShareSongLyrics shareSongLyrics,
    required AuthService authService,
    required FirestoreSongLyricsRepository firestoreSongLyricsRepository,
  })  : _authService = authService,
        _firestoreSongLyricsRepository = firestoreSongLyricsRepository,
        super(ShareLyricsState(lyricsWidgetKey: GlobalKey(), shareSongLyrics: shareSongLyrics)) {
    on<SaveNShareLyrics>(_onSaveNShareLyrics);
    on<SaveLyrics>(_onSaveLyrics);
  }

  final AuthService _authService;
  final FirestoreSongLyricsRepository _firestoreSongLyricsRepository;

  Future<void> _onSaveNShareLyrics(SaveNShareLyrics event, Emitter<ShareLyricsState> emit) async {
    emit(state.copyWith(status: ShareLyricsStateStatus.savingNSharingLyrics));
    try {
      final userUUID = _authService.currentUser?.uid;
      if (userUUID == null) {
        emit(state.copyWith(status: ShareLyricsStateStatus.savingNSharingLyricsFailed));
        await _authService.signOut();
        return;
      }

      final lyricsWidgetKey = state.lyricsWidgetKey;
      final shareSongLyrics = state.shareSongLyrics;
      await _firestoreSongLyricsRepository.saveSongLyrics(userUUID: userUUID, shareSongLyrics: shareSongLyrics);
      final cardLyricsBytes = await _captureLyricsCardImage(lyricsWidgetKey);
      await _share(cardLyricsBytes);
      emit(state.copyWith(status: ShareLyricsStateStatus.savingNSharingLyricsSucceeded));
    } catch (error, stacktrace) {
      log('FAILED TO SAVE & SHARE SONG, error: $error \n\n $stacktrace');
      emit(state.copyWith(status: ShareLyricsStateStatus.savingNSharingLyricsFailed, error: error.toString()));
    }
  }

  Future<void> _onSaveLyrics(SaveLyrics event, Emitter<ShareLyricsState> emit) async {
    emit(state.copyWith(status: ShareLyricsStateStatus.savingLyrics));
    final userUUID = _authService.currentUser?.uid;
    if (userUUID == null) {
      emit(state.copyWith(status: ShareLyricsStateStatus.savingNSharingLyricsFailed));
      await _authService.signOut();
      return;
    }

    final shareSongLyrics = state.shareSongLyrics;
    await _firestoreSongLyricsRepository.saveSongLyrics(userUUID: userUUID, shareSongLyrics: shareSongLyrics).then((_) {
      emit(state.copyWith(status: ShareLyricsStateStatus.savingLyricsSucceeded));
    }).catchError((Object error, StackTrace stacktrace) async {
      log('FAILED TO SAVE SONG LYRICS, error: $error \n\n $stacktrace');
      emit(state.copyWith(status: ShareLyricsStateStatus.savingNSharingLyricsFailed, error: error.toString()));
    });
  }

  Future<Uint8List> _captureLyricsCardImage(GlobalKey lyricsWidgetKey) async {
    try {
      final boundary = lyricsWidgetKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      final bytes = byteData!.buffer.asUint8List();
      return bytes;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> _share(Uint8List bytes) async {
    try {
      final directory = (await getTemporaryDirectory()).path;
      final path = '$directory/${DateTime.now().millisecondsSinceEpoch}.png';
      await File(path).writeAsBytes(bytes);
      await Share.shareXFiles([XFile(path)]);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
