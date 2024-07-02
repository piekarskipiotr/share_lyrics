part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.status = StateStatus.initial,
    this.user,
    this.error,
  });

  final StateStatus status;
  final User? user;
  final String? error;

  SettingsState copyWith({
    StateStatus? status,
    User? user,
    String? error,
  }) {
    return SettingsState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, user, error];
}
