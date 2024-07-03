part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

final class ToggleSearchPage extends HomeEvent {
  const ToggleSearchPage({required this.showSearch});

  final bool showSearch;

  @override
  List<Object?> get props => [showSearch];
}

final class ChangeSearchPhrase extends HomeEvent {
  const ChangeSearchPhrase({required this.phrase});

  final String phrase;

  @override
  List<Object?> get props => [phrase];
}
