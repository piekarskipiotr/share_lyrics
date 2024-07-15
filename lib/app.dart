import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/data/repositories/firebase_auth/firebase_auth_repository.dart';
import 'package:share_lyrics/data/repositories/firebase_store/firestore_song_lyrics_repository.dart';
import 'package:share_lyrics/data/repositories/genius_repository/genius_repository.dart';
import 'package:share_lyrics/l10n/l10n.dart';
import 'package:share_lyrics/router/app_router.dart';
import 'package:share_lyrics/router/app_router_navigation.dart';
import 'package:share_lyrics/services/auth_service/auth_service.dart';
import 'package:share_lyrics/services/auth_service/bloc/auth_bloc.dart';
import 'package:share_lyrics/services/feed_service/feed_service.dart';
import 'package:share_lyrics/services/search_service/search_service.dart';

class App extends StatelessWidget {
  const App({
    required FirebaseAuthRepository firebaseAuthRepository,
    required FirestoreSongLyricsRepository firestoreSongLyricsRepository,
    required GeniusRepository geniusRepository,
    required AuthService authService,
    required SearchService searchService,
    required FeedService feedService,
    required AppRouter router,
    super.key,
  })  : _firebaseAuthRepository = firebaseAuthRepository,
        _firestoreSongLyricsRepository = firestoreSongLyricsRepository,
        _geniusRepository = geniusRepository,
        _authService = authService,
        _searchService = searchService,
        _feedService = feedService,
        _router = router;

  final FirebaseAuthRepository _firebaseAuthRepository;
  final FirestoreSongLyricsRepository _firestoreSongLyricsRepository;
  final GeniusRepository _geniusRepository;
  final AuthService _authService;
  final SearchService _searchService;
  final FeedService _feedService;
  final AppRouter _router;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _firebaseAuthRepository),
        RepositoryProvider.value(value: _firestoreSongLyricsRepository),
        RepositoryProvider.value(value: _geniusRepository),
        RepositoryProvider.value(value: _authService),
        RepositoryProvider.value(value: _searchService),
        RepositoryProvider.value(value: _feedService),
        RepositoryProvider.value(value: _router),
      ],
      child: BlocProvider(
        create: (context) => AuthBloc(_authService),
        child: BlocListener<AuthBloc, AuthState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                context.read<AppRouter>().showHome();
              case AuthenticationStatus.unauthenticated:
              case AuthenticationStatus.unknown:
                context.read<AppRouter>().showSignIn();
            }
          },
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(textTheme: GoogleFonts.openSansTextTheme()),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routeInformationProvider: _router.router.routeInformationProvider,
            routeInformationParser: _router.router.routeInformationParser,
            routerDelegate: _router.router.routerDelegate,
          ),
        ),
      ),
    );
  }
}
