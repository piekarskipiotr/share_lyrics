import 'package:flutter/material.dart';

extension StringExtensions on String {
  String toTitleCase() {
    if (isEmpty) {
      return this;
    }

    return split(' ').map((word) {
      if (word.isEmpty) {
        return word;
      }
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}

extension ContextExtensions on BuildContext {
  bool get isDarkTheme  => Theme.of(this).brightness == Brightness.dark;
}
