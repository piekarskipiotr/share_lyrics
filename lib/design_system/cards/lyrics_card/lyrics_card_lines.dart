import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/cards/lyrics_card/lyrics_card_line.dart';

class LyricsCardLines extends StatelessWidget {
  const LyricsCardLines({required this.lines, super.key});

  final List<String> lines;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) => LyricsCardLine(line: line)).toList(),
    );
  }
}
