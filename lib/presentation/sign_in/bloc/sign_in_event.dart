part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();
}

final class SignInWithProvider extends SignInEvent {
  const SignInWithProvider({required this.signInProvider});

  final SignInProvider signInProvider;

  @override
  List<Object?> get props => [signInProvider];
}
