import 'package:flutter/material.dart';
import 'package:share_lyrics/data/models/song/song_media.dart';
import 'package:share_lyrics/design_system/song_media/song_media_list_view.dart';
import 'package:share_lyrics/design_system/song_media/song_media_loading.dart';

class SongMediaList extends StatelessWidget {
  const SongMediaList({required this.songMedia, required this.isLoading, super.key});

  final List<SongMedia> songMedia;
  final bool isLoading;
  static const _animationDuration = Duration(milliseconds: 250);
  static const _defaultPadding = EdgeInsets.only(bottom: 24);

  @override
  Widget build(BuildContext context) {
    final hasAnySongMedia = songMedia.isNotEmpty;
    return AnimatedSwitcher(
      duration: _animationDuration,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: isLoading
          ? const Padding(padding: _defaultPadding, child: SongMediaLoading())
          : hasAnySongMedia
              ? Padding(padding: _defaultPadding, child: SongMediaListView(songMedia: songMedia))
              : null,
    );
  }
}
