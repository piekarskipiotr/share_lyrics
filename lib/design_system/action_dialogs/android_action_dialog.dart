import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class AndroidActionDialog extends StatelessWidget {
  const AndroidActionDialog({
    required this.title,
    required this.subtitle,
    required this.primaryText,
    required this.secondaryText,
    required this.onPrimaryPressed,
    required this.onSecondaryPressed,
    required this.isPrimaryDestructive,
    super.key,
  });

  final String title;
  final String subtitle;
  final String primaryText;
  final String secondaryText;
  final VoidCallback onPrimaryPressed;
  final VoidCallback onSecondaryPressed;
  final bool isPrimaryDestructive;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: AppActionDialogsStyles.h9(fontWeight: FontWeight.w600)),
      content: Text(subtitle, style: AppActionDialogsStyles.h10()),
      backgroundColor: AppColors.blackBg,
      actions: [
        ElevatedButton(
          onPressed: onPrimaryPressed,
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(isPrimaryDestructive ? AppColors.red : AppColors.black),
            backgroundColor: WidgetStateProperty.all(isPrimaryDestructive ? AppColors.red : AppColors.black),
          ),
          child: Text(primaryText, style: AppActionDialogsStyles.h9(fontWeight: FontWeight.w500)),
        ),
        TextButton(
          onPressed: onSecondaryPressed,
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(AppColors.transparent),
            backgroundColor: WidgetStateProperty.all(AppColors.transparent),
          ),
          child: Text(secondaryText, style: AppActionDialogsStyles.h9()),
        ),
      ],
    );
  }
}
