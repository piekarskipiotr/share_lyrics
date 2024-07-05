import 'package:flutter/material.dart';
import 'package:share_lyrics/data/models/song/song_media.dart';
import 'package:share_lyrics/presentation/song_details/widgets/song_media/song_media_list_view.dart';
import 'package:share_lyrics/presentation/song_details/widgets/song_media/song_media_loading.dart';

class SongMediaList extends StatelessWidget {
  const SongMediaList({required this.songMedia, required this.isLoading, super.key});

  final List<SongMedia> songMedia;
  final bool isLoading;
  static const _animationDuration = Duration(milliseconds: 250);
  static const _defaultPadding = EdgeInsets.only(bottom: 24);
  static const _zeroPadding = EdgeInsets.zero;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: _animationDuration,
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: isLoading
          ? const Padding(
              padding: _defaultPadding,
              child: SongMediaLoading(),
            )
          : Padding(
              padding: songMedia.isEmpty ? _zeroPadding : _defaultPadding,
              child: SongMediaListView(songMedia: songMedia),
            ),
    );
  }
}
