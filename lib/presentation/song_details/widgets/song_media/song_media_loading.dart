import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class SongMediaLoading extends StatelessWidget {
  const SongMediaLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 7),
        AppShimmer(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Container(
              height: 16,
              width: 56,
              decoration: const BoxDecoration(
                color: AppColors.fieldBg,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        AppShimmer(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(children: List.generate(3, (_) => _buildSongMediaButton())),
          ),
        ),
      ],
    );
  }

  Widget _buildSongMediaButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Container(
        height: 40,
        width: 116,
        decoration: const BoxDecoration(
          color: AppColors.fieldBg,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }
}
