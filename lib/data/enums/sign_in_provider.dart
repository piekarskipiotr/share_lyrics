import 'package:flutter/material.dart';
import 'package:share_lyrics/resources/resources.dart';

enum SignInProvider {
  google,
  apple;

  String get logo {
    switch (this) {
      case SignInProvider.google:
        return SignInIcons.googleIcon;
      case SignInProvider.apple:
        return SignInIcons.appleIcon;
    }
  }

  Color get buttonBackgroundColor {
    switch (this) {
      case SignInProvider.google:
        return Colors.white;
      case SignInProvider.apple:
        return Colors.black;
    }
  }

  Color get buttonTextColor {
    switch (this) {
      case SignInProvider.google:
        return Colors.black;
      case SignInProvider.apple:
        return Colors.white;
    }
  }

  ColorFilter? get logoColorFilter {
    switch (this) {
      case SignInProvider.google:
        return null;
      case SignInProvider.apple:
        return const ColorFilter.mode(
          Colors.white,
          BlendMode.srcIn,
        );
    }
  }

  String get name {
    switch (this) {
      case SignInProvider.google:
        return 'Google';
      case SignInProvider.apple:
        return 'Apple';
    }
  }
}
