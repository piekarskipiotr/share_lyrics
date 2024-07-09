import 'package:flutter/material.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/cards/lyrics_card/lyrics_card_header.dart';
import 'package:share_lyrics/design_system/cards/lyrics_card/lyrics_card_lines.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class LyricsCard extends StatelessWidget {
  const LyricsCard({required this.sharedLyrics, this.lyricsCardWidgetKey, super.key});

  final SharedLyrics sharedLyrics;
  final GlobalKey? lyricsCardWidgetKey;

  Widget get _defaultGap => const SizedBox(height: 24);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: lyricsCardWidgetKey,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(32)),
          color: AppColors.black,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LyricsCardHeader(
              artist: sharedLyrics.song.artist,
              title: sharedLyrics.song.title,
              image: sharedLyrics.song.image,
            ),
            _defaultGap,
            LyricsCardLines(lines: sharedLyrics.lyrics),
            _defaultGap,
          ],
        ),
      ),
    );
  }
}
