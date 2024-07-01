part of 'sign_in_bloc.dart';

class SignInState extends Equatable {
  const SignInState({
    this.status = StateStatus.initial,
    this.error,
  });

  final StateStatus status;
  final String? error;

  SignInState copyWith({
    StateStatus? status,
    String? error,
  }) {
    return SignInState(
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
