import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
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

  User? get currentUser => _firebaseAuthRepository.getCurrentUser();

  Future<void> signOut() async {
    await _firebaseAuthRepository.signOut();
  }

  Future<void> deleteAccount() async {
    await _firebaseAuthRepository.deleteAccount();
  }
}
