import 'package:share_lyrics/app.dart';
import 'package:share_lyrics/bootstrap.dart';
import 'package:share_lyrics/data/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:share_lyrics/router/app_router.dart';
import 'package:share_lyrics/services/auth_service/auth_service.dart';

void main() {
  bootstrap(() {
    final firebaseAuthRepository = FirebaseAuthRepository();
    final authService = AuthService(firebaseAuthRepository);
    final router = AppRouter();

    return App(
      firebaseAuthRepository: firebaseAuthRepository,
      authService: authService,
      router: router,
    );
  });
}
