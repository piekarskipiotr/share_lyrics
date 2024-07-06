import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/colors/app_colors.dart';

class AppBottomSheetDialog {
  static void show({required Widget child, required BuildContext context}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.blackBg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(38)),
      ),
      builder: (_) {
        return _AppBottomSheetDialogContainer(child: child);
      },
    );
  }
}

class _AppBottomSheetDialogContainer extends StatelessWidget {
  const _AppBottomSheetDialogContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 48),
          child: Column(
            children: [
              Container(
                height: 4,
                width: 64,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
              ),
              const SizedBox(height: 16),
              child,
              const SizedBox(height: 8),
            ],
          ),
        ),
      ],
    );
  }
}
