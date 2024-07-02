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
