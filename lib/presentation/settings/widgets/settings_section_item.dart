import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';

class SettingsSectionItem extends StatelessWidget {
  const SettingsSectionItem({
    required this.label,
    this.value,
    this.onTap,
    this.isDanger = false,
    super.key,
  });

  final String label;
  final dynamic value;
  final VoidCallback? onTap;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    final color = isDanger ? AppColors.red : AppColors.white;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            _buildText(label, color),
            const SizedBox(width: 16),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: _buildValueView(value, color.withOpacity(0.8)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValueView(dynamic value, Color color) {
    if (value is String) return _buildText(value, color);
    if (value is IconData) return Icon(value, color: color, size: 20);
    return const SizedBox();
  }

  Widget _buildText(String value, Color color) {
    return Text(
      value,
      style: AppTextStyles.h10(color: color),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
