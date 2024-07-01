import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({required this.body, this.meshGradientColors, super.key});

  final Widget body;
  final List<Color>? meshGradientColors;

  @override
  Widget build(BuildContext context) {
    final safeBody = SafeArea(child: body);
    return Scaffold(
      backgroundColor: AppColors.blackBg,
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
    );
  }
}
