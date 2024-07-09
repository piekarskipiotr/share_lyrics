import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/l10n/l10n.dart';
import 'package:share_lyrics/presentation/feed/bloc/feed_bloc.dart';
import 'package:share_lyrics/router/app_router.dart';
import 'package:share_lyrics/router/app_router_navigation.dart';

class FeedView extends StatefulWidget {
  const FeedView({super.key});

  @override
  State<FeedView> createState() => _FeedViewState();
}

class _FeedViewState extends State<FeedView> {
  final _pagingController = PagingController<int, SharedLyrics>(firstPageKey: 1);

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

  void _navigateToSharedLyricsDetails(SharedLyrics sharedLyrics) {
    context.read<AppRouter>().showSharedLyricsDetails(sharedLyrics: sharedLyrics);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FeedBloc, FeedState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _handleStateStatus,
      builder: (context, state) {
        return PagedListView<int, SharedLyrics>.separated(
          pagingController: _pagingController,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
          builderDelegate: PagedChildBuilderDelegate<SharedLyrics>(
            firstPageProgressIndicatorBuilder: (_) => _buildLoadingView(),
            newPageProgressIndicatorBuilder: (_) => _buildLoadingView(),
            newPageErrorIndicatorBuilder: (_) => const SizedBox(),
            noItemsFoundIndicatorBuilder: (_) => _buildEmptyView(),
            firstPageErrorIndicatorBuilder: (_) => const SizedBox(),
            noMoreItemsIndicatorBuilder: (_) => const SizedBox(),
            itemBuilder: (context, sharedLyrics, index) {
              return GestureDetector(
                onTap: () {
                  _navigateToSharedLyricsDetails(sharedLyrics);
                },
                behavior: HitTestBehavior.translucent,
                child: LyricsCard(sharedLyrics: sharedLyrics),
              );
            },
          ),
          separatorBuilder: (context, index) {
            return const SizedBox(height: 32);
          },
        );
      },
    );
  }

  Widget _buildLoadingView() {
    return const LyricsCardsLoading();
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
