import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:share_lyrics/data/constants.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/l10n/l10n.dart';
import 'package:share_lyrics/utils/helpers/helpers.dart';

class SignInTermsNPrivacyText extends StatelessWidget {
  const SignInTermsNPrivacyText({super.key});

  void _onTermsTapped() {
    UrlLauncher.open(termsOfServiceUrl);
  }

  void _onPrivacyTapped() {
    UrlLauncher.open(privacyPolicyUrl);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: AppTextStyles.h10(fontWeight: FontWeight.w300),
          children: [
            TextSpan(text: l10n.terms_n_privacy_pt_1),
            TextSpan(
              text: l10n.terms_n_privacy_pt_2,
              style: AppTextStyles.h10(fontWeight: FontWeight.w300, color: AppColors.primary),
              recognizer: TapGestureRecognizer()..onTap = _onTermsTapped,
            ),
            TextSpan(text: l10n.terms_n_privacy_pt_3),
            TextSpan(
              text: l10n.terms_n_privacy_pt_4,
              style: AppTextStyles.h10(fontWeight: FontWeight.w300, color: AppColors.primary),
              recognizer: TapGestureRecognizer()..onTap = _onPrivacyTapped,
            ),
          ],
        ),
      ),
    );
  }
}
