import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/router/app_router.dart';
import 'package:share_lyrics/router/app_routes.dart';

extension AppRouterNavigation on AppRouter {
  void showSignIn() => router.goNamed(AppRoutes.signIn);

  void showHome() => router.goNamed(AppRoutes.home);

  void showSongDetails({required Song song}) => router.pushNamed(AppRoutes.songDetails, extra: song);

  void showSettings() => router.pushNamed(AppRoutes.settings);
}
