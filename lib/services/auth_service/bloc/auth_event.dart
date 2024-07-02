part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

final class _AuthenticationStatusChanged extends AuthEvent {
  const _AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;

  @override
  List<Object?> get props => [status];
}

final class AuthenticationGuestRequested extends AuthEvent {
  @override
  List<Object?> get props => [];
}
