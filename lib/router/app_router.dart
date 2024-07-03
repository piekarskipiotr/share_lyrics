import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/presentation/home/view/home_page.dart';
import 'package:share_lyrics/presentation/settings/view/settings_page.dart';
import 'package:share_lyrics/presentation/sign_in/view/sign_in_page.dart';
import 'package:share_lyrics/presentation/song_details/view/song_details_page.dart';
import 'package:share_lyrics/router/app_routes.dart';

class AppRouter {
  late final router = GoRouter(
    initialLocation: '/${AppRoutes.signIn}',
    routes: [
      GoRoute(
        path: '/${AppRoutes.signIn}',
        name: AppRoutes.signIn,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SignInPage());
        },
      ),
      GoRoute(
        path: '/${AppRoutes.home}',
        name: AppRoutes.home,
        pageBuilder: (context, state) {
          return const MaterialPage(child: HomePage());
        },
      ),
      GoRoute(
        path: '/${AppRoutes.songDetails}',
        name: AppRoutes.songDetails,
        pageBuilder: (context, state) {
          final song = state.extra! as Song;
          return MaterialPage(child: SongDetailsPage(song: song));
        },
      ),
      GoRoute(
        path: '/${AppRoutes.settings}',
        name: AppRoutes.settings,
        pageBuilder: (context, state) {
          return const MaterialPage(child: SettingsPage());
        },
      ),
    ],
  );
}
