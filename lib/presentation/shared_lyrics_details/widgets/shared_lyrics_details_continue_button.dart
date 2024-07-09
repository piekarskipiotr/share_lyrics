import 'package:flutter/material.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/buttons/buttons.dart';
import 'package:share_lyrics/l10n/l10n.dart';

class SharedLyricsDetailsContinueButton extends StatelessWidget {
  const SharedLyricsDetailsContinueButton({
    required this.onPressed,
    required this.sharedLyrics,
    super.key,
  });

  final SharedLyrics sharedLyrics;
  final void Function(SharedLyrics sharedLyrics) onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: AppButton(
            label: l10n.share,
            onPressed: () => onPressed.call(sharedLyrics),
          ),
        ),
      ),
    );
  }
}
