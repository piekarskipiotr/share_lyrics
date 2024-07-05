import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/presentation/song_details/bloc/song_details_bloc.dart';

class SongDetailsAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SongDetailsAppBar({
    required this.song,
    required this.scrollController,
    required this.showTitleInAppBar,
    super.key,
  });

  final Song song;
  final ScrollController scrollController;
  final bool showTitleInAppBar;

  @override
  State<SongDetailsAppBar> createState() => _SongDetailsAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SongDetailsAppBarState extends State<SongDetailsAppBar> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  void _changeVisibilityOfTitleInAppBar(bool value) {
    context.read<SongDetailsBloc>().add(ChangeVisibilityOfTitleInAppBar(showTitleInAppBar: value));
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

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.transparent,
      surfaceTintColor: AppColors.transparent,
      leading: IconButton(
        onPressed: _navigateBack,
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
      ),
      title: AnimatedOpacity(
        opacity: widget.showTitleInAppBar ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            children: [
              TextSpan(
                text: widget.song.artist,
                style: AppTextStyles.h8(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: ' - ',
                style: AppTextStyles.h8(fontWeight: FontWeight.bold),
              ),
              TextSpan(
                text: widget.song.title,
                style: AppTextStyles.h8(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
