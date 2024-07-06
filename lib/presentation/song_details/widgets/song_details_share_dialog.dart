import 'package:flutter/material.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/l10n/l10n.dart';

class SongDetailsShareDialog extends StatelessWidget {
  const SongDetailsShareDialog({required this.shareSongLyrics, super.key});

  final ShareSongLyrics shareSongLyrics;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        SongLyricsCard(shareSongLyrics: shareSongLyrics),
        const SizedBox(height: 48),
        AppButton(label: l10n.save_n_share, onPressed: () {}),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.translucent,
          child: Text(l10n.just_save, style: AppTextStyles.h7()),
        ),
      ],
    );
  }
}
