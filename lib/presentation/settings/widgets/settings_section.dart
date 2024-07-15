import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/presentation/settings/widgets/settings_section_item.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({required this.label, required this.children, super.key});

  final String label;
  final List<SettingsSectionItem> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.h8(fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => children[index],
            separatorBuilder: (context, index) {
              return const SizedBox(height: 4);
            },
            itemCount: children.length,
          ),
        ],
      ),
    );
  }
}
