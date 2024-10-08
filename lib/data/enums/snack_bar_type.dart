import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

enum SnackBarType {
  success,
  error;

  Color get backgroundGradientColor => switch (this) {
        success => AppColors.green,
        error => AppColors.red,
      };

  Color get iconColor => switch (this) {
        success => AppColors.fieldBg,
        error => AppColors.white,
      };

  IconData get icon => switch (this) {
        success => Icons.done_rounded,
        error => Icons.error_outline_rounded,
      };
}
