import 'package:flutter/material.dart';
import 'package:share_lyrics/data/enums/song_details_type.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class SongDetailsRow extends StatelessWidget {
  const SongDetailsRow({required this.song, required this.type, this.onTap, super.key});

  final Song song;
  final SongDetailsType type;
  final void Function(Song song)? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap?.call(song) : null,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: type.outerPadding,
        child: Row(
          children: [
            SongImage(imageUrl: song.image, imageSize: type.songImageSize),
            SizedBox(width: type.spaceBetweenImageAndDetails),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    song.artist,
                    style: type.artistTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    song.title,
                    style: type.titleTextStyle,
                    maxLines: type.titleMaxLines,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
