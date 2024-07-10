import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/presentation/share_lyrics_dialog/view/share_lyrics_dialog.dart';
import 'package:share_lyrics/presentation/song_details/bloc/song_details_bloc.dart';
import 'package:share_lyrics/presentation/song_details/constants/song_details_state_status.dart';
import 'package:share_lyrics/presentation/song_details/widgets/song_details_continue_button.dart';

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

  void _changeVisibilityOfTitleInAppBar({required bool value}) {
    context.read<SongDetailsBloc>().add(ChangeVisibilityOfTitleInAppBar(showTitleInAppBar: value));
  }

  void _onLyricTap(Lyric lyric) {
    context.read<SongDetailsBloc>().add(SelectLine(lyric: lyric));
  }

  void _onContinueButtonPressed(Song song, List<String> lyrics) {
    final sharedLyrics = SharedLyrics(lyrics: lyrics, song: song);
    AppBottomSheetDialog.show(child: ShareLyricsDialog(sharedLyrics: sharedLyrics), context: context);
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
          appBar: DetailsAppBar(
            song: song,
            scrollController: _scrollController,
            changeVisibilityOfTitle: _changeVisibilityOfTitleInAppBar,
            showTitle: showTitleInAppBar,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    SongDetailsRow(song: song, type: SongDetailsType.large),
                    const SizedBox(height: 16),
                    SongMediaList(songMedia: songMedia, isLoading: isLoading),
                    SongLyrics(lyrics: lyrics, onTap: _onLyricTap, isLoading: isLoading),
                    const SizedBox(height: 196),
                  ],
                ),
              ),
              AppVerticalGradient(extendUpperGradient: showTitleInAppBar),
              SongDetailsContinueButton(song: song, lyrics: lyrics, onPressed: _onContinueButtonPressed),
            ],
          ),
        );
      },
    );
  }
}
