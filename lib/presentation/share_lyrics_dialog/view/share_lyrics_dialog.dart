import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/presentation/share_lyrics_dialog/bloc/share_lyrics_bloc.dart';
import 'package:share_lyrics/presentation/share_lyrics_dialog/view/share_lyrics_dialog_view.dart';

class ShareLyricsDialog extends StatelessWidget {
  const ShareLyricsDialog({
    required this.sharedLyrics,
    this.quickShare = false,
    this.quickSaveToGallery = false,
    super.key,
  });

  final SharedLyrics sharedLyrics;
  final bool quickShare;
  final bool quickSaveToGallery;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShareLyricsBloc(
        sharedLyrics: sharedLyrics,
        quickShare: quickShare,
        quickSaveToGallery: quickSaveToGallery,
        authService: context.read(),
        firestoreSongLyricsRepository: context.read(),
      ),
      child: const ShareLyricsDialogView(),
    );
  }
}
