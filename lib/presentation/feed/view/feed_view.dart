import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/l10n/l10n.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  @override
  Widget build(BuildContext context) {
    return _buildEmptyView();
  }

  Widget _buildEmptyView() {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Text(
          l10n.empty_feed,
          textAlign: TextAlign.center,
          style: AppTextStyles.h9(color: AppColors.white.withOpacity(0.75)),
        ),
      ),
    );
  }
}
