import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class SongsLoading extends StatelessWidget {
  const SongsLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: List.generate(10, (_) => _songItem())),
      ),
    );
  }

  Widget _songItem() {
    const imageSize = 56.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(imageSize / 2),
            child: Container(
              height: imageSize,
              width: imageSize,
              color: AppColors.fieldBg,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 16,
                width: 150,
                decoration: const BoxDecoration(
                  color: AppColors.fieldBg,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 16,
                width: 250,
                decoration: const BoxDecoration(
                  color: AppColors.fieldBg,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
