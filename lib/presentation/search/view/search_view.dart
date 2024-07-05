import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/l10n/l10n.dart';
import 'package:share_lyrics/presentation/search/bloc/search_bloc.dart';
import 'package:share_lyrics/presentation/search/widgets/song_item.dart';
import 'package:share_lyrics/presentation/search/widgets/songs_loading.dart';
import 'package:share_lyrics/router/app_router.dart';
import 'package:share_lyrics/router/app_router_navigation.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  void _navigateToSongDetails(Song song) {
    context.read<AppRouter>().showSongDetails(song: song);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        final songs = [...?state.results];
        final isLoading = state.status == StateStatus.loading;
        if (isLoading) return const SongsLoading();
        if (songs.isEmpty) return _buildEmptyView();
        return _buildResultsView(songs);
      },
    );
  }

  Widget _buildEmptyView() {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Text(
          l10n.empty_search,
          textAlign: TextAlign.center,
          style: AppTextStyles.h9(color: AppColors.white.withOpacity(0.75)),
        ),
      ),
    );
  }

  Widget _buildResultsView(List<Song> songs) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ...songs.map((song) => SongItem(song: song, onTap: _navigateToSongDetails)),
          ],
        ),
      ),
    );
  }
}
