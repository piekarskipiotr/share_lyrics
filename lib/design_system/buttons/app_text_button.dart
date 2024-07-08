import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    required this.label,
    required this.onPressed,
    this.textColor = AppColors.white,
    this.isLoading = false,
    this.disableOnPressed = false,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final Color textColor;
  final bool isLoading;
  final bool disableOnPressed;

  static const _circularProgressSize = 24.0;
  static const _circularProgressStrokeWidth = 2.5;
  static const _circularProgressColor = AlwaysStoppedAnimation<Color>(AppColors.white);
  static const _circularProgressSpace = 16.0;
  static const _circularProgressOpacityDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading || disableOnPressed ? () {} : onPressed,
      behavior: HitTestBehavior.translucent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: isLoading ? 1 : 0,
            duration: _circularProgressOpacityDuration,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: _circularProgressSize,
                  height: _circularProgressSize,
                  child: Center(
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: _circularProgressStrokeWidth,
                      valueColor: _circularProgressColor,
                    ),
                  ),
                ),
                SizedBox(width: _circularProgressSpace),
              ],
            ),
          ),
          Text(
            label,
            style: AppTextStyles.h7(fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(width: _circularProgressSize + _circularProgressSpace),
        ],
      ),
    );
  }
}
