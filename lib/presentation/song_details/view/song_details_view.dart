import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/presentation/song_details/bloc/song_details_bloc.dart';
import 'package:share_lyrics/presentation/song_details/constants/song_details_state_status.dart';
import 'package:share_lyrics/presentation/song_details/widgets/song_details_app_bar.dart';
import 'package:share_lyrics/presentation/song_details/widgets/song_details_continue_button.dart';
import 'package:share_lyrics/presentation/song_details/widgets/song_details_header.dart';
import 'package:share_lyrics/presentation/song_details/widgets/song_details_share_dialog.dart';
import 'package:share_lyrics/presentation/song_details/widgets/song_details_vertical_gradient.dart';
import 'package:share_lyrics/presentation/song_details/widgets/song_lyrics/song_lyrics.dart';
import 'package:share_lyrics/presentation/song_details/widgets/song_media/song_media_list.dart';
import 'package:share_lyrics/presentation/widgets/app_scaffold.dart';

class SongDetailsView extends StatefulWidget {
  const SongDetailsView({super.key});

  @override
  State<SongDetailsView> createState() => _SongDetailsViewState();
}

class _SongDetailsViewState extends State<SongDetailsView> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleStateStatus(BuildContext context, SongDetailsState state) {
    switch (state.status) {
      case _:
        break;
    }
  }

  void _onLyricTap(Lyric lyric) {
    context.read<SongDetailsBloc>().add(SelectLine(lyric: lyric));
  }

  void _onContinueButtonPressed(Song song, List<String> lyrics) {
    final shareSongLyrics = ShareSongLyrics(title: song.title, artist: song.artist, image: song.image, lyrics: lyrics);
    AppBottomSheetDialog.show(child: SongDetailsShareDialog(shareSongLyrics: shareSongLyrics), context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SongDetailsBloc, SongDetailsState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _handleStateStatus,
      builder: (context, state) {
        final song = state.song;
        final songMedia = [...?song.media];
        final lyrics = [...?state.lyrics];
        final isLoading = state.status == SongDetailsStateStatus.fetchingSongData;
        final showTitleInAppBar = state.showTitleInAppBar;
        return AppScaffold(
          backgroundColor: AppColors.black,
          ignoreBottomSafeArea: true,
          appBar: SongDetailsAppBar(
            song: song,
            scrollController: _scrollController,
            showTitleInAppBar: showTitleInAppBar,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    SongDetailsHeader(song: song),
                    const SizedBox(height: 16),
                    SongMediaList(songMedia: songMedia, isLoading: isLoading),
                    SongLyrics(lyrics: lyrics, onTap: _onLyricTap, isLoading: isLoading),
                    const SizedBox(height: 196),
                  ],
                ),
              ),
              SongDetailsVerticalGradient(showTitleInAppBar: showTitleInAppBar),
              SongDetailsContinueButton(song: song, lyrics: lyrics, onPressed: _onContinueButtonPressed),
            ],
          ),
        );
      },
    );
  }
}
