import 'package:flutter/material.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/design_system/song_lyrics/song_lyrics_line.dart';
import 'package:share_lyrics/l10n/l10n.dart';

class SongLyricsView extends StatelessWidget {
  const SongLyricsView({required this.lyrics, required this.onTap, super.key});

  final List<Lyric> lyrics;
  final void Function(Lyric lyric) onTap;

  @override
  Widget build(BuildContext context) {
    if (lyrics.isEmpty) return _buildEmptyView(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: lyrics.length,
        itemBuilder: (context, index) {
          final lyric = lyrics[index];
          return SongLyricsLine(lyric: lyric, onTap: onTap);
        },
      ),
    );
  }

  Widget _buildEmptyView(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Text(
          l10n.empty_lyrics,
          textAlign: TextAlign.center,
          style: AppTextStyles.h9(color: AppColors.white.withOpacity(0.75)),
        ),
      ),
    );
  }
}
