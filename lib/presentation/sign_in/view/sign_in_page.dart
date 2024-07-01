import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_lyrics/presentation/sign_in/bloc/sign_in_bloc.dart';
import 'package:share_lyrics/presentation/sign_in/view/sign_in_view.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInBloc(firebaseAuthRepository: context.read()),
      child: const SignInView(),
    );
  }
}
