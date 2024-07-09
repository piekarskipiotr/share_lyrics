import 'package:flutter/material.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class AppDropdownMenu extends StatelessWidget {
  const AppDropdownMenu({required this.child, required this.items, super.key});

  final Widget child;
  final List<AppDropdownMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<AppDropdownMenuItem>(
      icon: child,
      color: AppColors.blackBg,
      padding: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      position: PopupMenuPosition.under,
      onSelected: (dropdownMenuItem) {
        dropdownMenuItem.onTap.call();
      },
      itemBuilder: (BuildContext context) {
        return _mapItems(items);
      },
    );
  }

  List<PopupMenuEntry<AppDropdownMenuItem>> _mapItems(List<AppDropdownMenuItem> items) {
    return items
        .map((AppDropdownMenuItem item) {
          final color = item.isDanger ? AppColors.red : AppColors.white;
          final entry = PopupMenuItem<AppDropdownMenuItem>(
            value: item,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(item.icon, color: color, size: 24),
                const SizedBox(width: 12),
                Text(
                  item.label,
                  style: AppTextStyles.h9(color: color),
                ),
              ],
            ),
          );

          final isLastItem = items.last == item;
          return [entry, if (!isLastItem) _divider];
        })
        .expand((i) => i)
        .toList();
  }

  PopupMenuEntry<AppDropdownMenuItem> get _divider => PopupMenuItem<AppDropdownMenuItem>(
        enabled: false,
        height: 1,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          color: AppColors.fieldBg,
          height: 1,
        ),
      );
}
