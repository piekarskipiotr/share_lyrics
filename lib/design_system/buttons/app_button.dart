import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.textColor = AppColors.black,
    this.backgroundColor = AppColors.white,
    this.isLoading = false,
    this.disableOnPressed = false,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final Color textColor;
  final Color backgroundColor;
  final bool isLoading;
  final bool disableOnPressed;

  static const _buttonHeight = 64.0;
  static const _circularProgressSize = 24.0;
  static const _circularProgressStrokeWidth = 2.5;
  static const _circularProgressColor = AlwaysStoppedAnimation<Color>(AppColors.black);
  static const _circularProgressSpace = 16.0;
  static const _circularProgressOpacityDuration = Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _buttonHeight,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(backgroundColor),
          backgroundColor: WidgetStateProperty.all(backgroundColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          ),
        ),
        onPressed: isLoading || disableOnPressed ? () {} : onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
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
                style: AppTextStyles.h7(fontWeight: FontWeight.w600, color: textColor),
              ),
              const SizedBox(width: _circularProgressSize + _circularProgressSpace),
            ],
          ),
        ),
      ),
    );
  }
}
