import 'package:flutter/material.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/buttons/buttons.dart';
import 'package:share_lyrics/l10n/l10n.dart';

class SongDetailsContinueButton extends StatelessWidget {
  const SongDetailsContinueButton({
    required this.onPressed,
    required this.song,
    required this.lyrics,
    super.key,
  });

  final Song song;
  final List<Lyric> lyrics;
  final void Function(Song song, List<String> lyrics) onPressed;

  bool get _isAnyLyricSelected => lyrics.any((lyric) => lyric.isSelected);

  List<String> get _selectedLyrics => lyrics.where((lyric) => lyric.isSelected).map((lyric) => lyric.line).toList();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AnimatedOpacity(
      opacity: _isAnyLyricSelected ? 1 : 0,
      duration: const Duration(milliseconds: 200),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: AppButton(
              label: l10n.continue_button,
              onPressed: () => onPressed.call(song, _selectedLyrics),
            ),
          ),
        ),
      ),
    );
  }
}
