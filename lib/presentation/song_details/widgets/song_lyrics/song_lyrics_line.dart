import 'package:flutter/material.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class SongLyricsLine extends StatefulWidget {
  const SongLyricsLine({required this.lyric, required this.onTap, super.key});

  final Lyric lyric;
  final void Function(Lyric lyric) onTap;

  @override
  State<SongLyricsLine> createState() => _SongLyricsLineState();
}

class _SongLyricsLineState extends State<SongLyricsLine> {
  static const _animationDuration = Duration(milliseconds: 200);

  Color getBackgroundColor(Lyric lyric) {
    if (lyric.isSelected) return AppColors.fieldBg;
    if (lyric.isNextLineSelected || lyric.isPreviousLineSelected) return AppColors.fieldBg.withOpacity(0.5);
    return AppColors.transparent;
  }

  BorderRadiusGeometry? getBorderRadius(Lyric lyric) {
    if (lyric.isSelected && lyric.isNextLineSelected) {
      return const BorderRadius.only(
        topLeft: Radius.circular(26),
        topRight: Radius.circular(26),
      );
    }

    if (lyric.isSelected && lyric.isPreviousLineSelected) {
      return const BorderRadius.only(
        bottomRight: Radius.circular(26),
        bottomLeft: Radius.circular(26),
      );
    }

    if (lyric.isSelected || lyric.isNextLineSelected || lyric.isPreviousLineSelected) {
      return const BorderRadius.all(Radius.circular(26));
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = getBackgroundColor(widget.lyric);
    final borderRadius = getBorderRadius(widget.lyric);
    return GestureDetector(
      onTap: () => widget.onTap.call(widget.lyric),
      child: AnimatedContainer(
        duration: _animationDuration,
        width: double.infinity,
        decoration: BoxDecoration(color: backgroundColor, borderRadius: borderRadius),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Text(
            widget.lyric.line,
            textAlign: TextAlign.start,
            style: AppTextStyles.h6(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
