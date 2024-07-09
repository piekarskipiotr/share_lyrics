import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/presentation/shared_lyrics_details/bloc/shared_lyrics_details_bloc.dart';
import 'package:share_lyrics/presentation/shared_lyrics_details/view/shared_lyrics_details_view.dart';

class SharedLyricsDetailsPage extends StatelessWidget {
  const SharedLyricsDetailsPage({required this.shareSongLyrics, super.key});

  final ShareSongLyrics shareSongLyrics;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SharedLyricsDetailsBloc(
        shareSongLyrics: shareSongLyrics,
        geniusRepository: context.read(),
        firestoreSongLyricsRepository: context.read(),
      ),
      child: const SharedLyricsDetailsView(),
    );
  }
}
