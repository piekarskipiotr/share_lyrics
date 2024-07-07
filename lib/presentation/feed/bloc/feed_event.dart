part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();
}

final class FetchSongLyrics extends FeedEvent {
  const FetchSongLyrics({required this.page});

  final int page;

  @override
  List<Object?> get props => [page];
}
