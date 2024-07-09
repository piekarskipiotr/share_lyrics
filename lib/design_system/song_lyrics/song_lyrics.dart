import 'package:flutter/material.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/song_lyrics/song_lyrics_loading.dart';
import 'package:share_lyrics/design_system/song_lyrics/song_lyrics_view.dart';

class SongLyrics extends StatelessWidget {
  const SongLyrics({required this.lyrics, required this.onTap, required this.isLoading, super.key});

  final List<Lyric> lyrics;
  final void Function(Lyric lyric) onTap;
  final bool isLoading;
  static const _animationDuration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: _animationDuration,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: isLoading ? const SongLyricsLoading() : SongLyricsView(lyrics: lyrics, onTap: onTap),
    );
  }
}
