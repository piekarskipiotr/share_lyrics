import 'package:flutter/cupertino.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/utils/extensions/extensions.dart';

class IOSActionDialog extends StatelessWidget {
  const IOSActionDialog({
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
    final textColor = context.isDarkTheme ? AppColors.white : AppColors.black;
    return CupertinoAlertDialog(
      title: Text(title, style: AppActionDialogsStyles.h9(color: textColor, fontWeight: FontWeight.w600)),
      content: Text(subtitle, style: AppActionDialogsStyles.h10(color: textColor)),
      actions: [
        CupertinoDialogAction(
          onPressed: onSecondaryPressed,
          child: Text(secondaryText, style: AppActionDialogsStyles.h9(color: AppColors.iosBlueText)),
        ),
        CupertinoDialogAction(
          onPressed: onPrimaryPressed,
          isDefaultAction: true,
          isDestructiveAction: isPrimaryDestructive,
          child: Text(
            primaryText,
            style: AppActionDialogsStyles.h9(
              color: isPrimaryDestructive ? AppColors.iosRedText : AppColors.iosBlueText,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
