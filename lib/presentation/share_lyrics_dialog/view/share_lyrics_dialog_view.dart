import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_lyrics/data/enums/enums.dart';
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
      case ShareLyricsStateStatus.savingToGallerySucceeded:
      case ShareLyricsStateStatus.sharingLyricsSucceeded:
      case ShareLyricsStateStatus.savingLyricsSucceeded:
      case ShareLyricsStateStatus.savingNSharingLyricsSucceeded:
        context.pop();
      case _:
        break;
    }
  }

  void _onSaveNShareLyricsPressed() {
    context.read<ShareLyricsBloc>().add(const SaveNShareLyrics());
  }

  void _onSaveLyricsPressed() {
    context.read<ShareLyricsBloc>().add(const SaveLyrics());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<ShareLyricsBloc, ShareLyricsState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _handleStateStatus,
      builder: (context, state) {
        final mode = state.mode;
        final lyricsCardWidgetKey = state.lyricsWidgetKey;
        final sharedLyrics = state.sharedLyrics;
        final isSavingNSharingLyrics = state.status == ShareLyricsStateStatus.savingNSharingLyrics;
        final isSavingLyrics = state.status == ShareLyricsStateStatus.savingLyrics;
        final isLoading = isSavingNSharingLyrics || isSavingLyrics;

        return Column(
          children: [
            LyricsCard(sharedLyrics: sharedLyrics, lyricsCardWidgetKey: lyricsCardWidgetKey),
            if (mode == ShareLyricsDialogMode.normal) ...[
              const SizedBox(height: 48),
              AppButton(
                label: l10n.save_n_share,
                onPressed: _onSaveNShareLyricsPressed,
                isLoading: isSavingNSharingLyrics,
                disableOnPressed: isLoading,
              ),
              const SizedBox(height: 24),
              AppTextButton(
                label: l10n.just_save,
                onPressed: _onSaveLyricsPressed,
                isLoading: isSavingLyrics,
                disableOnPressed: isLoading,
              ),
            ],
          ],
        );
      },
    );
  }
}
