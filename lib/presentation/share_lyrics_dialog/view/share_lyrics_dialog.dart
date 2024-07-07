import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/presentation/share_lyrics_dialog/bloc/share_lyrics_bloc.dart';
import 'package:share_lyrics/presentation/share_lyrics_dialog/view/share_lyrics_dialog_view.dart';

class ShareLyricsDialog extends StatelessWidget {
  const ShareLyricsDialog({required this.shareSongLyrics, super.key});

  final ShareSongLyrics shareSongLyrics;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ShareLyricsBloc(
        shareSongLyrics: shareSongLyrics,
        authService: context.read(),
        firestoreSongLyricsRepository: context.read(),
      ),
      child: const ShareLyricsDialogView(),
    );
  }
}
