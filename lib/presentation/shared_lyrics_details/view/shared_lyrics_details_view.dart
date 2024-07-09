import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/presentation/share_lyrics_dialog/view/share_lyrics_dialog.dart';
import 'package:share_lyrics/presentation/shared_lyrics_details/bloc/shared_lyrics_details_bloc.dart';
import 'package:share_lyrics/presentation/shared_lyrics_details/constants/shared_lyrics_details_state_status.dart';
import 'package:share_lyrics/presentation/shared_lyrics_details/widgets/shared_lyrics_details_app_bar.dart';
import 'package:share_lyrics/presentation/shared_lyrics_details/widgets/shared_lyrics_details_continue_button.dart';
import 'package:share_lyrics/presentation/shared_lyrics_details/widgets/shared_lyrics_details_header.dart';
import 'package:share_lyrics/presentation/shared_lyrics_details/widgets/shared_lyrics_details_vertical_gradient.dart';
import 'package:share_lyrics/presentation/widgets/app_scaffold.dart';

class SharedLyricsDetailsView extends StatefulWidget {
  const SharedLyricsDetailsView({super.key});

  @override
  State<SharedLyricsDetailsView> createState() => _SharedLyricsDetailsViewState();
}

class _SharedLyricsDetailsViewState extends State<SharedLyricsDetailsView> {
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

  void _handleStateStatus(BuildContext context, SharedLyricsDetailsState state) {
    switch (state.status) {
      case _:
        break;
    }
  }

  void _onContinueButtonPressed(ShareSongLyrics shareSongLyrics) {
    AppBottomSheetDialog.show(
      child: ShareLyricsDialog(shareSongLyrics: shareSongLyrics, quickShare: true),
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SharedLyricsDetailsBloc, SharedLyricsDetailsState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _handleStateStatus,
      builder: (context, state) {
        final shareSongLyrics = state.shareSongLyrics;
        final songMedia = [...?state.songMedia];
        final isLoading = state.status == SharedLyricsDetailsStateStatus.fetchingSongData;
        final showTitleInAppBar = state.showTitleInAppBar;

        return AppScaffold(
          backgroundColor: AppColors.black,
          ignoreBottomSafeArea: true,
          appBar: SharedLyricsDetailsAppBar(
            shareSongLyrics: shareSongLyrics,
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
                    SharedLyricsDetailsHeader(shareSongLyrics: shareSongLyrics),
                    const SizedBox(height: 16),
                    SongMediaList(songMedia: songMedia, isLoading: isLoading),
                    SongLyrics(
                      lyrics: shareSongLyrics.lyrics.map((lyric) => Lyric(line: lyric)).toList(),
                      onTap: (_) {},
                      isLoading: false,
                    ),
                    const SizedBox(height: 196),
                  ],
                ),
              ),
              SharedLyricsDetailsVerticalGradient(showTitleInAppBar: showTitleInAppBar),
              SharedLyricsDetailsContinueButton(shareSongLyrics: shareSongLyrics, onPressed: _onContinueButtonPressed),
            ],
          ),
        );
      },
    );
  }
}
