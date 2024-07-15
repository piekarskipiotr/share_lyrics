part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

final class Search extends SearchEvent {
  const Search({required this.phrase});

  final String phrase;

  @override
  List<Object?> get props => [phrase];
}
