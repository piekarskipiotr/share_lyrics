import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_lyrics/presentation/feed/bloc/feed_bloc.dart';
import 'package:share_lyrics/presentation/feed/view/feed_view.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeedBloc(
        authService: context.read(),
        feedService: context.read(),
        firestoreSongLyricsRepository: context.read(),
      ),
      child: const FeedView(),
    );
  }
}
