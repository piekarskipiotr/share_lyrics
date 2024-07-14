import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

enum SongDetailsType {
  small,
  medium,
  large;

  EdgeInsetsGeometry get outerPadding => switch (this) {
        small => EdgeInsets.zero,
        medium => const EdgeInsets.symmetric(vertical: 16),
        large => const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      };

  double get songImageSize => switch (this) {
        small => 42.0,
        medium => 56.0,
        large => 96.0,
      };

  double get spaceBetweenImageAndDetails => switch (this) {
        large => 24.0,
        _ => 16.0,
      };

  TextStyle get artistTextStyle => switch (this) {
        small => AppTextStyles.h10(),
        medium => AppTextStyles.h9(),
        large => AppTextStyles.h7(),
      };

  TextStyle get titleTextStyle => switch (this) {
        small => AppTextStyles.h10(color: AppColors.primary, fontWeight: FontWeight.w600),
        medium => AppTextStyles.h9(color: AppColors.primary, fontWeight: FontWeight.w600),
        large => AppTextStyles.h7(color: AppColors.primary, fontWeight: FontWeight.w600),
      };

  int get titleMaxLines => switch (this) {
        large => 2,
        _ => 1,
      };
}
