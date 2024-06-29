import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_lyrics/presentation/sign_in/view/sign_in_page.dart';
import 'package:share_lyrics/router/app_routes.dart';

class AppRouter {
  late final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        redirect: (context, state) async {
          // TODO(piotr): handle auth
          return '/${AppRoutes.signIn}';
        },
      ),
      GoRoute(
        path: '/${AppRoutes.signIn}',
        name: AppRoutes.signIn,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignInPage());
        },
      ),
    ],
  );
}
