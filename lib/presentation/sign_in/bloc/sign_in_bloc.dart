import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/data/repositories/firebase_auth/firebase_auth_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required FirebaseAuthRepository firebaseAuthRepository})
      : _firebaseAuthRepository = firebaseAuthRepository,
        super(const SignInState()) {
    on<SignInWithProvider>(_onSignInWithProvider);
  }

  final FirebaseAuthRepository _firebaseAuthRepository;

  Future<void> _onSignInWithProvider(SignInWithProvider event, Emitter<SignInState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));
    final signInProvider = event.signInProvider;
    switch (signInProvider) {
      case SignInProvider.google:
        await _signInWithGoogle(emit);
      case SignInProvider.apple:
        await _signInWithApple(emit);
    }
  }

  Future<void> _signInWithGoogle(Emitter<SignInState> emit) async {
    await _firebaseAuthRepository.signInWithGoogle().then((_) async {
      emit(state.copyWith(status: StateStatus.success));
    }).catchError((Object error, StackTrace stacktrace) async {
      log('FAILED TO SIGN IN WITH GOOGLE, error: $error \n\n $stacktrace');
      emit(state.copyWith(status: StateStatus.failure, error: error.toString()));
    });
  }

  Future<void> _signInWithApple(Emitter<SignInState> emit) async {
    await _firebaseAuthRepository.signInWithApple().then((_) async {
      emit(state.copyWith(status: StateStatus.success));
    }).catchError((Object error, StackTrace stacktrace) async {
      log('FAILED TO SIGN IN WITH APPLE, error: $error \n\n $stacktrace');
      emit(state.copyWith(status: StateStatus.failure, error: error.toString()));
    });
  }
}
