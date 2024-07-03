import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:shimmer/shimmer.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer({
    this.baseColor = AppColors.fieldBg,
    this.highlightColor = AppColors.shimmerHighlight,
    this.duration = const Duration(milliseconds: 1000),
    this.child,
    super.key,
  });

  final Color baseColor;
  final Color highlightColor;
  final Duration duration;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: duration,
      child: child ?? Container(color: AppColors.fieldBg),
    );
  }
}
