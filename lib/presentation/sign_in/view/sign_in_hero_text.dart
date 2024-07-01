import 'package:flutter/material.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/l10n/l10n.dart';

class SignInHeroText extends StatelessWidget {
  const SignInHeroText({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: AppTextStyles.h3(fontWeight: FontWeight.w900),
            children: [
              TextSpan(text: l10n.sign_in_hero_title_pt_1),
              TextSpan(
                text: l10n.sign_in_hero_title_pt_2,
                style: AppTextStyles.h3(fontWeight: FontWeight.w900, color: AppColors.primary),
              ),
              TextSpan(text: l10n.sign_in_hero_title_pt_3),
            ],
          ),
        ),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: AppTextStyles.h7(fontWeight: FontWeight.w300),
            children: [
              TextSpan(text: l10n.sign_in_hero_description_pt_1),
              TextSpan(
                text: l10n.sign_in_hero_description_pt_2,
                style: AppTextStyles.h7(fontWeight: FontWeight.w300, color: AppColors.primary),
              ),
              TextSpan(text: l10n.sign_in_hero_description_pt_3),
            ],
          ),
        ),
      ],
    );
  }
}
