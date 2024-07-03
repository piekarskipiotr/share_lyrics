import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_lyrics/presentation/home/bloc/home_bloc.dart';
import 'package:share_lyrics/presentation/home/view/home_app_bar.dart';
import 'package:share_lyrics/presentation/widgets/app_scaffold.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: NestedScrollView(
        physics: const NeverScrollableScrollPhysics(),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [const HomeAppBar()];
        },
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final showSearch = state.showSearch;
            return showSearch ? state.searchPage : state.feedPage;
          },
        ),
      ),
    );
  }
}
