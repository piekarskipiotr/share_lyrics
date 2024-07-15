import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/l10n/l10n.dart';
import 'package:share_lyrics/resources/resources.dart';

class LyricsCardCredits extends StatelessWidget {
  const LyricsCardCredits({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _shareLyricsCredits(context)),
        const SizedBox(width: 32),
        Expanded(child: _geniusCredits(context)),
      ],
    );
  }

  Widget _shareLyricsCredits(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        SvgPicture.asset(
          AppLogos.shareLyricsLogoVariant,
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 8),
        RichText(
          text: TextSpan(
            style: AppTextStyles.h10(fontWeight: FontWeight.w900),
            children: [
              TextSpan(text: l10n.app_name_pt_1),
              TextSpan(
                text: l10n.app_name_pt_2,
                style: AppTextStyles.h10(fontWeight: FontWeight.w900, color: AppColors.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _geniusCredits(BuildContext context) {
    final l10n = context.l10n;
    return RichText(
      textAlign: TextAlign.end,
      text: TextSpan(
        style: AppTextStyles.h12(),
        children: [
          TextSpan(text: l10n.genius_credits_pt_1),
          TextSpan(
            text: l10n.genius_credits_pt_2,
            style: AppTextStyles.h12(fontWeight: FontWeight.bold, color: AppColors.geniusPrimary),
          ),
          TextSpan(text: l10n.genius_credits_pt_3),
        ],
      ),
    );
  }
}
