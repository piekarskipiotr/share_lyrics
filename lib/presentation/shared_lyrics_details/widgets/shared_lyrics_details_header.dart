import 'package:flutter/material.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class SharedLyricsDetailsHeader extends StatelessWidget {
  const SharedLyricsDetailsHeader({required this.shareSongLyrics, super.key});

  final ShareSongLyrics shareSongLyrics;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Row(
        children: [
          SongImage(imageUrl: shareSongLyrics.image, imageSize: 96),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shareSongLyrics.artist,
                  style: AppTextStyles.h7(fontWeight: FontWeight.w300),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  shareSongLyrics.title,
                  style: AppTextStyles.h7(color: AppColors.primary, fontWeight: FontWeight.w600),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
