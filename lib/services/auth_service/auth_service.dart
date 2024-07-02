import 'dart:async';

import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/data/repositories/firebase_auth/firebase_auth_repository.dart';

class AuthService {
  AuthService(this._firebaseAuthRepository) {
    initializeFirebaseAuthStatus();
  }

  final FirebaseAuthRepository _firebaseAuthRepository;
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    yield* _controller.stream;
  }

  Future<void> initializeFirebaseAuthStatus() async {
    _firebaseAuthRepository.authStateChanges().listen((user) {
      final status = user != null ? AuthenticationStatus.authenticated : AuthenticationStatus.unauthenticated;
      _controller.add(status);
    });
  }

  Future<bool> isAuthenticated() async {
    return _firebaseAuthRepository.isAuthenticated();
  }

  Future<void> logOut() async {
    await _firebaseAuthRepository.signOut();
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void setAuthenticationStatus(AuthenticationStatus status) {
    _controller.add(status);
  }
}
