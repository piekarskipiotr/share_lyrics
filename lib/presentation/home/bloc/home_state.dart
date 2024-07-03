part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState({
    this.showSearch = false,
    this.feedPage = const FeedPage(),
    this.searchPage = const SearchPage(),
    this.error,
  });

  final bool showSearch;
  final Widget feedPage;
  final Widget searchPage;
  final String? error;

  HomeState copyWith({
    bool? showSearch,
    String? error,
  }) {
    return HomeState(
      showSearch: showSearch ?? this.showSearch,
      feedPage: feedPage,
      searchPage: searchPage,
      error: error,
    );
  }

  @override
  List<Object?> get props => [showSearch, feedPage, searchPage, error];
}
