import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/l10n/l10n.dart';
import 'package:share_lyrics/presentation/share_lyrics_dialog/bloc/share_lyrics_bloc.dart';
import 'package:share_lyrics/presentation/share_lyrics_dialog/constants/share_lyrics_state_status.dart';

class ShareLyricsDialogView extends StatefulWidget {
  const ShareLyricsDialogView({super.key});

  @override
  State<ShareLyricsDialogView> createState() => _ShareLyricsDialogViewState();
}

class _ShareLyricsDialogViewState extends State<ShareLyricsDialogView> {
  void _handleStateStatus(BuildContext context, ShareLyricsState state) {
    switch (state.status) {
      case ShareLyricsStateStatus.savingLyricsSucceeded:
      case ShareLyricsStateStatus.savingNSharingLyricsSucceeded:
        _closeDialog();
      case _:
        break;
    }
  }

  void _closeDialog() {
    context.pop();
  }

  void _saveNShareLyrics() {
    context.read<ShareLyricsBloc>().add(const SaveNShareLyrics());
  }

  void _saveLyrics() {
    context.read<ShareLyricsBloc>().add(const SaveLyrics());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<ShareLyricsBloc, ShareLyricsState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _handleStateStatus,
      builder: (context, state) {
        final lyricsCardWidgetKey = state.lyricsWidgetKey;
        final shareSongLyrics = state.shareSongLyrics;
        final isSavingNSharingLyrics = state.status == ShareLyricsStateStatus.savingNSharingLyrics;
        final isSavingLyrics = state.status == ShareLyricsStateStatus.savingLyrics;
        final isLoading = isSavingNSharingLyrics || isSavingLyrics;

        return Column(
          children: [
            SongLyricsCard(shareSongLyrics: shareSongLyrics, lyricsCardWidgetKey: lyricsCardWidgetKey),
            const SizedBox(height: 48),
            AppButton(
              label: l10n.save_n_share,
              onPressed: _saveNShareLyrics,
              isLoading: isSavingNSharingLyrics,
              disableOnPressed: isLoading,
            ),
            const SizedBox(height: 24),
            AppTextButton(
              label: l10n.just_save,
              onPressed: _saveLyrics,
              isLoading: isSavingLyrics,
              disableOnPressed: isLoading,
            ),
          ],
        );
      },
    );
  }
}
