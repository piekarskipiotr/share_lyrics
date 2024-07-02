import 'package:flutter/cupertino.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class IOSActionDialog extends StatelessWidget {
  const IOSActionDialog({
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
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(subtitle),
      actions: [
        CupertinoDialogAction(
          onPressed: onSecondaryPressed,
          child: Text(secondaryText, style: AppTextStyles.h9(color: AppColors.iosBlueText)),
        ),
        CupertinoDialogAction(
          onPressed: onPrimaryPressed,
          isDestructiveAction: true,
          child: Text(primaryText),
        ),
      ],
    );
  }
}
