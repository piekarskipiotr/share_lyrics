import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/services/auth_service/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authService) : super(const AuthState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    _authenticationStatusSubscription = _authService.status.listen(
      (status) => add(_AuthenticationStatusChanged(status)),
    );
  }

  final AuthService _authService;
  late StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  Future<void> _onAuthenticationStatusChanged(_AuthenticationStatusChanged event, Emitter<AuthState> emit) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthState.unauthenticated());
      case AuthenticationStatus.authenticated:
        return emit(const AuthState.authenticated());
      case AuthenticationStatus.unknown:
        return emit(const AuthState.unknown());
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }
}
