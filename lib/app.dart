import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_lyrics/l10n/l10n.dart';
import 'package:share_lyrics/router/app_router.dart';

class App extends StatelessWidget {
  const App({
    required AppRouter router,
    super.key,
  }) : _router = router;

  final AppRouter _router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(textTheme: GoogleFonts.openSansTextTheme()),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routeInformationProvider: _router.router.routeInformationProvider,
      routeInformationParser: _router.router.routeInformationParser,
      routerDelegate: _router.router.routerDelegate,
    );
  }
}
