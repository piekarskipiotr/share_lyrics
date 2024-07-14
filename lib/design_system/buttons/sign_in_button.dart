import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_lyrics/data/enums/sign_in_provider.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/l10n/l10n.dart';

class SignInButton extends StatelessWidget {
  const SignInButton({
    required this.signInProvider,
    required this.onPressed,
    super.key,
  });

  final SignInProvider signInProvider;
  final void Function(SignInProvider) onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SizedBox(
      height: 64,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          overlayColor: WidgetStateProperty.all(signInProvider.buttonBackgroundColor),
          backgroundColor: WidgetStateProperty.all(signInProvider.buttonBackgroundColor),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
          ),
        ),
        onPressed: () => onPressed(signInProvider),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              SvgPicture.asset(
                signInProvider.logo,
                width: 32,
                height: 32,
                colorFilter: signInProvider.logoColorFilter,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                l10n.sign_in_with(signInProvider.name),
                style: AppTextStyles.h8(
                  fontWeight: FontWeight.w600,
                  color: signInProvider.buttonTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
