import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/design_system/buttons/buttons.dart';
import 'package:share_lyrics/design_system/colors/app_colors.dart';
import 'package:share_lyrics/presentation/sign_in/bloc/sign_in_bloc.dart';
import 'package:share_lyrics/presentation/sign_in/view/sign_in_hero_text.dart';
import 'package:share_lyrics/presentation/sign_in/view/sign_in_terms_n_privacy_text.dart';
import 'package:share_lyrics/presentation/widgets/app_scaffold.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  void _handleStateStatus(BuildContext context, SignInState state) {
    switch (state.status) {
      case StateStatus.loading:
      // TODO(piotr): display error toast
      case _:
        break;
    }
  }

  void _onSignInProvider(SignInProvider signInProvider) {
    context.read<SignInBloc>().add(SignInWithProvider(signInProvider: signInProvider));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _handleStateStatus,
      builder: (context, state) {
        final isLoading = state.status == StateStatus.loading;
        return Stack(
          children: [
            AbsorbPointer(
              absorbing: isLoading,
              child: AppScaffold(
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
              ),
            ),
            if (isLoading) _signingInOverlay(),
          ],
        );
      },
    );
  }

  Widget _signingInOverlay() {
    return ColoredBox(
      color: AppColors.black.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator(color: AppColors.white),
      ),
    );
  }
}
