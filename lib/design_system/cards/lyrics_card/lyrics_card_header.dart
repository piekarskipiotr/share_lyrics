import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class LyricsCardHeader extends StatelessWidget {
  const LyricsCardHeader({required this.artist, required this.title, this.image, super.key});

  final String? image;
  final String artist;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SongImage(imageUrl: image, imageSize: 42),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                artist,
                style: AppTextStyles.h10(fontWeight: FontWeight.w300),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                title,
                style: AppTextStyles.h10(color: AppColors.primary, fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
