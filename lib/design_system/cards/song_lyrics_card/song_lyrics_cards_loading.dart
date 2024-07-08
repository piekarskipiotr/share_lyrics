import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class SongLyricsCardsLoading extends StatelessWidget {
  const SongLyricsCardsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(10, (_) => _card()),
    );
  }

  Widget _card() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 34),
      child: AppShimmer(
        child: Container(
          height: 256,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(32)),
            color: AppColors.black,
          ),
        ),
      ),
    );
  }
}
