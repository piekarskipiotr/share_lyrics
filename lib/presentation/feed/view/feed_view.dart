import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/l10n/l10n.dart';
import 'package:share_lyrics/presentation/feed/bloc/feed_bloc.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  final _pagingController = PagingController<int, ShareSongLyrics>(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((page) {
      context.read<FeedBloc>().add(FetchSongLyrics(page: page));
    });
  }

  void _handleStateStatus(BuildContext context, FeedState state) {
    switch (state.status) {
      case StateStatus.success:
        final page = state.page;
        final pageSize = state.pageSize;
        final results = [...?state.results];
        final resultsCount = results.length;
        final isLastPage = pageSize > resultsCount;

        isLastPage ? _pagingController.appendLastPage(results) : _pagingController.appendPage(results, page + 1);
      case _:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _handleStateStatus,
      builder: (context, state) {
        return PagedListView<int, ShareSongLyrics>(
          pagingController: _pagingController,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
          builderDelegate: PagedChildBuilderDelegate<ShareSongLyrics>(
            firstPageProgressIndicatorBuilder: (_) => const SizedBox(),
            newPageProgressIndicatorBuilder: (_) => const SizedBox(),
            newPageErrorIndicatorBuilder: (_) => const SizedBox(),
            noItemsFoundIndicatorBuilder: (_) => _buildEmptyView(),
            firstPageErrorIndicatorBuilder: (_) => const SizedBox(),
            noMoreItemsIndicatorBuilder: (_) => const SizedBox(),
            itemBuilder: (context, shareSongLyrics, index) {
              return SongLyricsCard(shareSongLyrics: shareSongLyrics);
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyView() {
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.all(48),
      child: Center(
        child: Text(
          l10n.empty_feed,
          textAlign: TextAlign.center,
          style: AppTextStyles.h9(color: AppColors.white.withOpacity(0.75)),
        ),
      ),
    );
  }
}
