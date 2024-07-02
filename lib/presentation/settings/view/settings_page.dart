import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_lyrics/presentation/settings/bloc/settings_bloc.dart';
import 'package:share_lyrics/presentation/settings/view/settings_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsBloc(authService: context.read()),
      child: const SettingsView(),
    );
  }
}
