part of 'feed_bloc.dart';

class FeedState extends Equatable {
  const FeedState({
    this.status = StateStatus.initial,
    this.pageSize = 10,
    this.page = 1,
    this.lastDocSnap,
    this.results,
    this.error,
  });

  final StateStatus status;
  final int pageSize;
  final int page;
  final DocumentSnapshot? lastDocSnap;
  final List<SharedLyrics>? results;
  final String? error;

  FeedState copyWith({
    StateStatus? status,
    int? pageSize,
    int? page,
    DocumentSnapshot? lastDocSnap,
    List<SharedLyrics>? results,
    String? error,
  }) {
    return FeedState(
      status: status ?? this.status,
      pageSize: pageSize ?? this.pageSize,
      page: page ?? this.page,
      lastDocSnap: lastDocSnap ?? this.lastDocSnap,
      results: results ?? this.results,
      error: error,
    );
  }

  FeedState clearLastDocSnapshot() {
    return FeedState(status: status);
  }

  @override
  List<Object?> get props => [status, pageSize, page, lastDocSnap, results, error];
}
