import 'package:share_lyrics/app.dart';
import 'package:share_lyrics/bootstrap.dart';
import 'package:share_lyrics/data/constants.dart';
import 'package:share_lyrics/data/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:share_lyrics/data/repositories/genius_repository/genius_repository.dart';
import 'package:share_lyrics/network/genius_api/genius_api.dart';
import 'package:share_lyrics/router/app_router.dart';
import 'package:share_lyrics/services/auth_service/auth_service.dart';
import 'package:share_lyrics/services/search_service/search_service.dart';

void main() {
  bootstrap(() {
    final firebaseAuthRepository = FirebaseAuthRepository();
    final geniusApi = GeniusApi.create(geniusAPIUrl);
    final geniusRepository = GeniusRepository(geniusApi);
    final authService = AuthService(firebaseAuthRepository);
    final searchService = SearchService();
    final router = AppRouter();

    return App(
      firebaseAuthRepository: firebaseAuthRepository,
      geniusRepository: geniusRepository,
      authService: authService,
      searchService: searchService,
      router: router,
    );
  });
}
