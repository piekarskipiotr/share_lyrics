import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class DetailsAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DetailsAppBar({
    required this.song,
    required this.showTitle,
    required this.scrollController,
    required this.changeVisibilityOfTitle,
    this.actions,
    super.key,
  });

  final Song song;
  final bool showTitle;
  final ScrollController scrollController;
  final void Function({required bool value}) changeVisibilityOfTitle;
  final List<Widget>? actions;

  @override
  State<DetailsAppBar> createState() => _DetailsAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _DetailsAppBarState extends State<DetailsAppBar> {
  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (widget.scrollController.offset >= 90 && !widget.showTitle) {
      widget.changeVisibilityOfTitle.call(value: true);
    } else if (widget.scrollController.offset < 90 && widget.showTitle) {
      widget.changeVisibilityOfTitle.call(value: false);
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
      actions: widget.actions,
      title: AnimatedOpacity(
        opacity: widget.showTitle ? 1.0 : 0.0,
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
