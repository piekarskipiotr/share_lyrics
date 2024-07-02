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
    super.key,
  });

  final String title;
  final String subtitle;
  final String primaryText;
  final String secondaryText;
  final VoidCallback onPrimaryPressed;
  final VoidCallback onSecondaryPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: AppTextStyles.h9()),
      content: Text(subtitle, style: AppTextStyles.h10()),
      backgroundColor: AppColors.blackBg,
      actions: [
        ElevatedButton(
          onPressed: onPrimaryPressed,
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(AppColors.red),
            backgroundColor: WidgetStateProperty.all(AppColors.red),
          ),
          child: Text(primaryText, style: AppTextStyles.h9()),
        ),
        TextButton(
          onPressed: onSecondaryPressed,
          child: Text(secondaryText, style: AppTextStyles.h9()),
        ),
      ],
    );
  }
}
