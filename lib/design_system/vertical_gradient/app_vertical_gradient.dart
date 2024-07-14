import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class AppVerticalGradient extends StatelessWidget {
  const AppVerticalGradient({required this.extendUpperGradient, super.key});

  final bool extendUpperGradient;
  static const _animationDuration = Duration(milliseconds: 500);
  static const _gradientColors = [AppColors.black, AppColors.transparent];

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedContainer(
            duration: _animationDuration,
            height: extendUpperGradient ? 200 : 24,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: _gradientColors,
              ),
            ),
          ),
          Container(
            height: 248,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: _gradientColors,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
