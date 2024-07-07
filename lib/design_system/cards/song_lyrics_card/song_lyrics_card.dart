import 'package:flutter/material.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/cards/song_lyrics_card/song_lyrics_card_header.dart';
import 'package:share_lyrics/design_system/cards/song_lyrics_card/song_lyrics_card_lines.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class SongLyricsCard extends StatelessWidget {
  const SongLyricsCard({required this.shareSongLyrics, this.lyricsCardWidgetKey, super.key});

  final ShareSongLyrics shareSongLyrics;
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
            SongLyricsCardHeader(
              artist: shareSongLyrics.artist,
              title: shareSongLyrics.title,
              image: shareSongLyrics.image,
            ),
            _defaultGap,
            SongLyricsCardLines(lines: shareSongLyrics.lyrics),
            _defaultGap,
          ],
        ),
      ),
    );
  }
}
