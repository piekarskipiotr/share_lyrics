import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class SharedLyricsDetailsVerticalGradient extends StatelessWidget {
  const SharedLyricsDetailsVerticalGradient({required this.showTitleInAppBar, super.key});

  final bool showTitleInAppBar;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            height: showTitleInAppBar ? 200 : 56,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.black,
                  AppColors.transparent,
                ],
              ),
            ),
          ),
          const Spacer(),
          Container(
            height: 248,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  AppColors.black,
                  AppColors.transparent,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
