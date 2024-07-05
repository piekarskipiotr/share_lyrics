import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class SongLyricsLoading extends StatelessWidget {
  const SongLyricsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(10, _lyricItem),
        ),
      ),
    );
  }

  Widget _lyricItem(int index) {
    return Padding(
      padding: index == 0 ? const EdgeInsets.only(top: 8, bottom: 16) : const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.fieldBg,
              borderRadius: BorderRadius.all(Radius.circular(28)),
            ),
            child: SizedBox(height: 56, width: double.infinity),
          ),
          if ([1, 2, 4, 7, 8].contains(index)) ...[
            const SizedBox(height: 4),
            const DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.fieldBg,
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              child: SizedBox(height: 56, width: 264),
            ),
          ],
        ],
      ),
    );
  }
}
