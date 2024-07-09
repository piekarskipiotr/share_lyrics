import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class LyricsCardLine extends StatelessWidget {
  const LyricsCardLine({required this.line, super.key});

  final String line;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8, bottom: 16),
      child: Text(
        line,
        textAlign: TextAlign.start,
        style: AppTextStyles.h6(fontWeight: FontWeight.bold),
      ),
    );
  }
}
