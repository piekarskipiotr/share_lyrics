import 'package:flutter/material.dart';

class AppDropdownMenuItem {
  AppDropdownMenuItem({
    required this.label,
    required this.icon,
    required this.isDanger,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool isDanger;
  final VoidCallback onTap;
}
