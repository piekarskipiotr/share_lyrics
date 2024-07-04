import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    required this.onPressed,
    this.textColor = AppColors.black,
    this.backgroundColor = AppColors.white,
    super.key,
  });

  final String label;
  final VoidCallback onPressed;
  final Color textColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(backgroundColor),
          backgroundColor: WidgetStateProperty.all(backgroundColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          ),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(
            label,
            style: AppTextStyles.h7(fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
      ),
    );
  }
}
