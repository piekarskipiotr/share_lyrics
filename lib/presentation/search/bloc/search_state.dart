part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState({
    this.status = StateStatus.initial,
    this.results,
    this.error,
  });

  final StateStatus status;
  final List<Song>? results;
  final String? error;

  SearchState copyWith({
    StateStatus? status,
    List<Song>? results,
    String? error,
  }) {
    return SearchState(
      status: status ?? this.status,
      results: results ?? this.results,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, results, error];
}
