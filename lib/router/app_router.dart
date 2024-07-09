import 'package:go_router/go_router.dart';
import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/presentation/home/view/home_page.dart';
import 'package:share_lyrics/presentation/settings/view/settings_page.dart';
import 'package:share_lyrics/presentation/shared_lyrics_details/view/shared_lyrics_details_page.dart';
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
        builder: (context, state) {
          return const SignInPage();
        },
      ),
      GoRoute(
        path: '/${AppRoutes.home}',
        name: AppRoutes.home,
        builder: (context, state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: '/${AppRoutes.songDetails}',
        name: AppRoutes.songDetails,
        builder: (context, state) {
          final song = state.extra! as Song;
          return SongDetailsPage(song: song);
        },
      ),
      GoRoute(
        path: '/${AppRoutes.sharedLyricsDetails}',
        name: AppRoutes.sharedLyricsDetails,
        builder: (context, state) {
          final shareSongLyrics = state.extra! as ShareSongLyrics;
          return SharedLyricsDetailsPage(shareSongLyrics: shareSongLyrics);
        },
      ),
      GoRoute(
        path: '/${AppRoutes.settings}',
        name: AppRoutes.settings,
        builder: (context, state) {
          return const SettingsPage();
        },
      ),
    ],
  );
}
