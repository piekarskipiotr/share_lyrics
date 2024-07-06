import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/cards/song_lyrics_card/song_lyrics_card_line.dart';

class SongLyricsCardLines extends StatelessWidget {
  const SongLyricsCardLines({required this.lines, super.key});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) => SongLyricsCardLine(line: line)).toList(),
    );
  }
}
