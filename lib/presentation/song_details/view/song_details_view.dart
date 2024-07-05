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
  late ScrollController _scrollController;
  bool _showTitleInAppBar = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >= 90 && !_showTitleInAppBar) {
      setState(() {
        _showTitleInAppBar = true;
      });
    } else if (_scrollController.offset < 90 && _showTitleInAppBar) {
      setState(() {
        _showTitleInAppBar = false;
      });
    }
  }

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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocConsumer<SongDetailsBloc, SongDetailsState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _handleStateStatus,
      builder: (context, state) {
        final song = state.song;
        final songMedia = [...?song.media];
        final lyrics = [...?state.lyrics];
        final isLoading = state.status == SongDetailsStateStatus.fetchingSongData;
        final isAnyLyricSelected = lyrics.any((lyric) => lyric.isSelected);
        return AppScaffold(
          backgroundColor: AppColors.black,
          ignoreBottomSafeArea: true,
          appBar: AppBar(
            backgroundColor: AppColors.transparent,
            surfaceTintColor: AppColors.transparent,
            leading: IconButton(
              onPressed: _navigateBack,
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.white),
            ),
            title: AnimatedOpacity(
              opacity: _showTitleInAppBar ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: song.artist,
                      style: AppTextStyles.h8(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: ' - ',
                      style: AppTextStyles.h8(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: song.title,
                      style: AppTextStyles.h8(color: AppColors.primary, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
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
                          ? const Padding(
                              padding: EdgeInsets.only(bottom: 24),
                              child: SongMediaLoading(),
                            )
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
                    const SizedBox(height: 196),
                  ],
                ),
              ),
              IgnorePointer(
                child: Positioned.fill(
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height: _showTitleInAppBar ? 200 : 56,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 248,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black,
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
          ),
        );
      },
    );
  }
}
