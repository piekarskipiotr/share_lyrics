import 'package:flutter/material.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/presentation/song_details/view/song_details_view.dart';

class SongDetailsPage extends StatelessWidget {
  const SongDetailsPage({required this.song, super.key});

  final Song song;

  @override
  Widget build(BuildContext context) {
    return const SongDetailsView();
  }
}
