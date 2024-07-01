import 'dart:io';

import 'package:flutter/material.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/design_system/buttons/buttons.dart';
import 'package:share_lyrics/presentation/sign_in/view/sign_in_hero_text.dart';
import 'package:share_lyrics/presentation/sign_in/view/sign_in_terms_n_privacy_text.dart';
import 'package:share_lyrics/presentation/widgets/app_scaffold.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  void _onSignInProvider(SignInProvider signInProvider) {}

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SignInHeroText(),
            const SizedBox(height: 110),
            SignInButton(signInProvider: SignInProvider.google, onPressed: _onSignInProvider),
            if (Platform.isIOS) ...[
              const SizedBox(height: 24),
              SignInButton(signInProvider: SignInProvider.apple, onPressed: _onSignInProvider),
            ],
            const SizedBox(height: 40),
            const SignInTermsNPrivacyText(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
