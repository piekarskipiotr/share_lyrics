import 'package:flutter/material.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class GradientView extends StatelessWidget {
  const GradientView({required this.direction, required this.height, super.key});

  final GradientDirection direction;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: direction == GradientDirection.topToBottom ? Alignment.topCenter : Alignment.bottomCenter,
          end: direction == GradientDirection.topToBottom ? Alignment.bottomCenter : Alignment.topCenter,
          colors: const [AppColors.black, AppColors.transparent],
        ),
      ),
    );
  }
}
