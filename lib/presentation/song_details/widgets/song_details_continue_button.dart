import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/buttons/buttons.dart';
import 'package:share_lyrics/l10n/l10n.dart';

class SongDetailsContinueButton extends StatelessWidget {
  const SongDetailsContinueButton({required this.isAnyLyricSelected, required this.onPressed, super.key});

  final bool isAnyLyricSelected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AnimatedOpacity(
      opacity: isAnyLyricSelected ? 1 : 0,
      duration: const Duration(milliseconds: 200),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: AppButton(
              label: l10n.continue_button,
              onPressed: onPressed,
            ),
          ),
        ),
      ),
    );
  }
}
