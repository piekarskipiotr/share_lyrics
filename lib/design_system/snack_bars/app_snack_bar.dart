import 'package:flutter/material.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class AppSnackBar {
  static const _outerRadius = Radius.circular(24);

  static void show({
    required BuildContext context,
    required String title,
    required String description,
    required SnackBarType type,
  }) {
    ScaffoldMessenger.maybeOf(context)?.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.fieldBg,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(_outerRadius)),
        padding: const EdgeInsets.all(4),
        elevation: 10,
        content: _AppSnackbarContent(title: title, description: description, type: type),
      ),
    );
  }
}

class _AppSnackbarContent extends StatelessWidget {
  const _AppSnackbarContent({required this.title, required this.description, required this.type});

  final String title;
  final String description;
  final SnackBarType type;
  static const _iconSize = 32.0;
  static const _innerRadius = Radius.circular(20);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(topLeft: _innerRadius, topRight: _innerRadius),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [type.backgroundGradientColor.withOpacity(0.4), AppColors.transparent],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(_iconSize / 2),
                child: Container(
                  height: _iconSize,
                  width: _iconSize,
                  color: AppColors.primary,
                  child: Icon(type.icon, color: type.iconColor),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, maxLines: 1, style: AppTextStyles.h9(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(description, maxLines: 3, style: AppTextStyles.h10()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
