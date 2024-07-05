import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/l10n/l10n.dart';
import 'package:share_lyrics/presentation/song_details/bloc/song_details_bloc.dart';
import 'package:share_lyrics/presentation/song_details/constants/song_details_state_status.dart';
import 'package:share_lyrics/presentation/song_details/widgets/song_information.dart';
import 'package:share_lyrics/presentation/song_details/widgets/song_lyrics/song_lyrics.dart';
import 'package:share_lyrics/presentation/song_details/widgets/song_lyrics/song_lyrics_loading.dart';
import 'package:share_lyrics/presentation/song_details/widgets/song_media/song_media_list.dart';
import 'package:share_lyrics/presentation/song_details/widgets/song_media/song_media_loading.dart';
import 'package:share_lyrics/presentation/widgets/app_scaffold.dart';

class SongDetailsView extends StatefulWidget {
  const SongDetailsView({super.key});

  @override
  State<SongDetailsView> createState() => _SongDetailsViewState();
}

class _SongDetailsViewState extends State<SongDetailsView> {
  void _handleStateStatus(BuildContext context, SongDetailsState state) {
    switch (state.status) {
      case _:
        break;
    }
  }

  void _navigateBack() {
    context.pop();
  }

  void _onLyricTap(Lyric lyric) {
    context.read<SongDetailsBloc>().add(SelectLine(lyric: lyric));
  }

  void _onContinueButtonPressed() {}

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppScaffold(
      backgroundColor: AppColors.black,
      ignoreBottomSafeArea: true,
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        leading: IconButton(
          onPressed: _navigateBack,
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
        ),
      ),
      body: BlocConsumer<SongDetailsBloc, SongDetailsState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: _handleStateStatus,
        builder: (context, state) {
          final song = state.song;
          final songMedia = [...?song.media];
          final lyrics = [...?state.lyrics];
          final isLoading = state.status == SongDetailsStateStatus.fetchingSongData;
          final isAnyLyricSelected = lyrics.any((lyric) => lyric.isSelected);
          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    SongInformation(song: song),
                    const SizedBox(height: 16),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      child: isLoading
                          ? const SongMediaLoading()
                          : Padding(
                              padding: const EdgeInsets.only(bottom: 24),
                              child: SongMediaList(songMedia: songMedia),
                            ),
                    ),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      switchInCurve: Curves.easeIn,
                      switchOutCurve: Curves.easeOut,
                      child: isLoading ? const SongLyricsLoading() : SongLyrics(lyrics: lyrics, onTap: _onLyricTap),
                    ),
                    const SizedBox(height: 148),
                  ],
                ),
              ),
              AnimatedOpacity(
                opacity: isAnyLyricSelected ? 1 : 0,
                duration: const Duration(milliseconds: 200),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: AppButton(
                        label: l10n.continue_button,
                        onPressed: _onContinueButtonPressed,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
