import 'package:share_lyrics/router/app_router.dart';
import 'package:share_lyrics/router/app_routes.dart';

extension AppRouterNavigation on AppRouter {
  void showSignIn() => router.goNamed(AppRoutes.signIn);

  void showRoot() => router.go('/');
}
