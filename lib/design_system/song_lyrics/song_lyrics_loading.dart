import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class SongLyricsLoading extends StatelessWidget {
  const SongLyricsLoading({super.key});

  static const _linesIndex = [1, 2, 4, 7, 8];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AppShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(10, _lyricsItem),
        ),
      ),
    );
  }

  Widget _lyricsItem(int index) {
    final padding = index == 0 ? const EdgeInsets.only(top: 8, bottom: 16) : const EdgeInsets.symmetric(vertical: 16);
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _lyricItem(width: double.infinity),
          if (_linesIndex.contains(index)) ...[
            const SizedBox(height: 4),
            _lyricItem(width: 264),
          ],
        ],
      ),
    );
  }

  Widget _lyricItem({required double width}) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.fieldBg,
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
      child: SizedBox(height: 56, width: width),
    );
  }
}
