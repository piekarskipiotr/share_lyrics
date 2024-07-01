import 'package:share_lyrics/router/app_router.dart';
import 'package:share_lyrics/router/app_routes.dart';

extension AppRouterNavigation on AppRouter {
  void showSignIn() => router.goNamed(AppRoutes.signIn);

  void showHome() => router.goNamed(AppRoutes.home);
}
