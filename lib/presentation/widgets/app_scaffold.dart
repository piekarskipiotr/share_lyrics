import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.meshGradientColors,
    this.backgroundColor = AppColors.blackBg,
    this.ignoreBottomSafeArea = false,
    super.key,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final List<Color>? meshGradientColors;
  final Color backgroundColor;
  final bool ignoreBottomSafeArea;

  @override
  Widget build(BuildContext context) {
    final safeBody = SafeArea(bottom: !ignoreBottomSafeArea, child: body);
    final safeBottomNavigationBar = bottomNavigationBar != null ? SafeArea(child: bottomNavigationBar!) : null;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: [...?meshGradientColors].isEmpty
          ? safeBody
          : AnimatedMeshGradient(
              colors: meshGradientColors ?? [],
              options: AnimatedMeshGradientOptions(
                speed: 3.5,
                grain: 0.2,
              ),
              child: safeBody,
            ),
      bottomNavigationBar: safeBottomNavigationBar,
    );
  }
}
