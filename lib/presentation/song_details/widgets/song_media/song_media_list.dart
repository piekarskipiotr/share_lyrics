import 'package:flutter/material.dart';
import 'package:share_lyrics/data/models/song/song_media.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/l10n/l10n.dart';

class SongMediaList extends StatelessWidget {
  const SongMediaList({required this.songMedia, super.key});

  final List<SongMedia> songMedia;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(l10n.song_media_label, style: AppTextStyles.h9(fontWeight: FontWeight.w500)),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ...songMedia.map(
                (media) => Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: SongMediaButton(songMedia: media),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
