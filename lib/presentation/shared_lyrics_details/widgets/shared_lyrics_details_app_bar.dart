import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/l10n/l10n.dart';
import 'package:share_lyrics/presentation/share_lyrics_dialog/view/share_lyrics_dialog.dart';
import 'package:share_lyrics/presentation/shared_lyrics_details/bloc/shared_lyrics_details_bloc.dart';

class SharedLyricsDetailsAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SharedLyricsDetailsAppBar({
    required this.shareSongLyrics,
    required this.scrollController,
    required this.showTitleInAppBar,
    super.key,
  });

  final ShareSongLyrics shareSongLyrics;
  final ScrollController scrollController;
  final bool showTitleInAppBar;

  @override
  State<SharedLyricsDetailsAppBar> createState() => _SharedLyricsDetailsAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SharedLyricsDetailsAppBarState extends State<SharedLyricsDetailsAppBar> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  void _changeVisibilityOfTitleInAppBar(bool value) {
    context.read<SharedLyricsDetailsBloc>().add(ChangeVisibilityOfTitleInAppBar(showTitleInAppBar: value));
  }

  void _scrollListener() {
    if (widget.scrollController.offset >= 90 && !widget.showTitleInAppBar) {
      _changeVisibilityOfTitleInAppBar(true);
    } else if (widget.scrollController.offset < 90 && widget.showTitleInAppBar) {
      _changeVisibilityOfTitleInAppBar(false);
    }
  }

  void _navigateBack() {
    context.pop();
  }

  // TODO(piotr): call this function like "show delete dialog" & move bloc call to function "_deleteSong"
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

  Future<void> _saveToGallery(ShareSongLyrics shareSongLyrics) async {
    final status = await Permission.photos.status;
    if (status.isGranted) {
      AppBottomSheetDialog.show(
        child: ShareLyricsDialog(shareSongLyrics: shareSongLyrics, quickSaveToGallery: true),
        context: context,
      );
      return;
    }

    if (status.isPermanentlyDenied) await openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppBar(
      backgroundColor: AppColors.transparent,
      surfaceTintColor: AppColors.transparent,
      leading: IconButton(
        onPressed: _navigateBack,
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
      ),
      actions: [
        AppDropdownMenu(
          items: [
            AppDropdownMenuItem(
              label: l10n.save_to_gallery,
              icon: Icons.save_alt_rounded,
              isDanger: false,
              onTap: () {
                _saveToGallery(widget.shareSongLyrics);
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
      title: AnimatedOpacity(
        opacity: widget.showTitleInAppBar ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.shareSongLyrics.artist,
                style: AppTextStyles.h8(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ' - ',
                style: AppTextStyles.h8(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: widget.shareSongLyrics.title,
                style: AppTextStyles.h8(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
