import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_lyrics/presentation/home/bloc/home_bloc.dart';
import 'package:share_lyrics/presentation/home/view/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(searchService: context.read()),
      child: const HomeView(),
    );
  }
}
