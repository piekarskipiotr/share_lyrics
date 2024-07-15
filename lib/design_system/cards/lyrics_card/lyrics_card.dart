import 'package:flutter/material.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/cards/lyrics_card/lyrics_card_credits.dart';
import 'package:share_lyrics/design_system/cards/lyrics_card/lyrics_card_lines.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class LyricsCard extends StatelessWidget {
  const LyricsCard({required this.sharedLyrics, this.lyricsCardWidgetKey, super.key});

  final SharedLyrics sharedLyrics;
  final GlobalKey? lyricsCardWidgetKey;

  Widget get _defaultGap => const SizedBox(height: 24);

  Widget get _smallGap => const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: lyricsCardWidgetKey,
      child: Container(
        constraints: const BoxConstraints(minHeight: 274),
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(24)),
          color: AppColors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SongDetailsRow(song: sharedLyrics.song, type: SongDetailsType.small),
                _defaultGap,
                LyricsCardLines(lines: sharedLyrics.lyrics),
                _defaultGap,
                _defaultGap,
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LyricsCardCredits(),
                _smallGap,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
