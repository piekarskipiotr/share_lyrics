import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_lyrics/presentation/search/bloc/search_bloc.dart';
import 'package:share_lyrics/presentation/search/view/search_view.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchBloc(searchService: context.read(), geniusRepository: context.read()),
      child: const SearchView(),
    );
  }
}
