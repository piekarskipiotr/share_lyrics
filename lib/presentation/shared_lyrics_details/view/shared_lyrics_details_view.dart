import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/l10n/l10n.dart';
import 'package:share_lyrics/presentation/share_lyrics_dialog/view/share_lyrics_dialog.dart';
import 'package:share_lyrics/presentation/shared_lyrics_details/bloc/shared_lyrics_details_bloc.dart';
import 'package:share_lyrics/presentation/shared_lyrics_details/constants/shared_lyrics_details_state_status.dart';
import 'package:share_lyrics/presentation/shared_lyrics_details/widgets/shared_lyrics_details_share_button.dart';

class SharedLyricsDetailsView extends StatefulWidget {
  const SharedLyricsDetailsView({super.key});

  @override
  State<SharedLyricsDetailsView> createState() => _SharedLyricsDetailsViewState();
}

class _SharedLyricsDetailsViewState extends State<SharedLyricsDetailsView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleStateStatus(BuildContext context, SharedLyricsDetailsState state) {
    switch (state.status) {
      case SharedLyricsDetailsStateStatus.deletingSharedLyricsSucceeded:
        context.pop();
      case _:
        break;
    }
  }

  void _onShareButtonPressed(SharedLyrics sharedLyrics) {
    AppBottomSheetDialog.show(
      child: ShareLyricsDialog(sharedLyrics: sharedLyrics, quickShare: true),
      context: context,
    );
  }

  void _changeVisibilityOfTitleInAppBar({required bool value}) {
    context.read<SharedLyricsDetailsBloc>().add(ChangeVisibilityOfTitleInAppBar(showTitleInAppBar: value));
  }

  void _deleteSong() {
    final l10n = context.l10n;
    AppActionDialog.show(
      title: l10n.shared_lyrics_delete_confirmation_title,
      subtitle: l10n.shared_lyrics_delete_confirmation_description,
      primaryText: l10n.delete,
      secondaryText: l10n.cancel,
      onPrimaryPressed: () {
        context.pop();
        context.read<SharedLyricsDetailsBloc>().add(const DeleteSharedLyrics());
      },
      onSecondaryPressed: () {
        context.pop();
      },
      context: context,
    );
  }

  Future<void> _saveToGallery(SharedLyrics sharedLyrics) async {
    final status = await Permission.photos.status;
    if (status.isGranted) {
      AppBottomSheetDialog.show(
        child: ShareLyricsDialog(sharedLyrics: sharedLyrics, quickSaveToGallery: true),
        context: context,
      );
      return;
    }

    if (status.isPermanentlyDenied) await openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<SharedLyricsDetailsBloc, SharedLyricsDetailsState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _handleStateStatus,
      builder: (context, state) {
        final sharedLyrics = state.sharedLyrics;
        final songMedia = [...?sharedLyrics.song.media];
        final showTitleInAppBar = state.showTitleInAppBar;

        return AppScaffold(
          backgroundColor: AppColors.black,
          ignoreBottomSafeArea: true,
          appBar: DetailsAppBar(
            song: sharedLyrics.song,
            scrollController: _scrollController,
            changeVisibilityOfTitle: _changeVisibilityOfTitleInAppBar,
            showTitle: showTitleInAppBar,
            actions: [
              AppDropdownMenu(
                items: [
                  AppDropdownMenuItem(
                    label: l10n.save_to_gallery,
                    icon: Icons.save_alt_rounded,
                    isDanger: false,
                    onTap: () {
                      _saveToGallery(sharedLyrics);
                    },
                  ),
                  AppDropdownMenuItem(
                    label: l10n.delete,
                    icon: Icons.delete_rounded,
                    isDanger: true,
                    onTap: _deleteSong,
                  ),
                ],
                child: const Icon(Icons.more_vert_rounded, color: AppColors.white),
              ),
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    SongDetailsRow(song: sharedLyrics.song, type: SongDetailsType.large),
                    const SizedBox(height: 16),
                    SongMediaList(songMedia: songMedia, isLoading: false),
                    SongLyrics(
                      lyrics: sharedLyrics.lyrics.map((lyric) => Lyric(line: lyric)).toList(),
                      onTap: (_) {},
                      isLoading: false,
                    ),
                    const SizedBox(height: 196),
                  ],
                ),
              ),
              AppVerticalGradient(extendUpperGradient: showTitleInAppBar),
              SharedLyricsDetailsShareButton(sharedLyrics: sharedLyrics, onPressed: _onShareButtonPressed),
            ],
          ),
        );
      },
    );
  }
}
