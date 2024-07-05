import 'package:flutter/material.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/presentation/song_details/widgets/song_lyrics/song_lyrics_line.dart';

class SongLyricsView extends StatelessWidget {
  const SongLyricsView({required this.lyrics, required this.onTap, super.key});

  final List<Lyric> lyrics;
  final void Function(Lyric lyric) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lyrics.map((lyric) => SongLyricsLine(lyric: lyric, onTap: onTap)).toList(),
      ),
    );
  }
}
