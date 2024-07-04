import 'package:flutter/material.dart';
import 'package:share_lyrics/data/models/song/song_media.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class SongMediaList extends StatelessWidget {
  const SongMediaList({required this.songMedia, super.key});

  final List<SongMedia> songMedia;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...songMedia.map(
          (media) => Padding(
            padding: const EdgeInsets.only(left: 20),
            child: SongMediaButton(songMedia: media),
          ),
        ),
      ],
    );
  }
}
