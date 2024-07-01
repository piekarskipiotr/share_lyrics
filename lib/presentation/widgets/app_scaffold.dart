import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({required this.body, super.key});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackBg,
      body: SafeArea(child: body),
    );
  }
}
