import 'package:share_lyrics/app.dart';
import 'package:share_lyrics/bootstrap.dart';
import 'package:share_lyrics/router/app_router.dart';

void main() {
  final router = AppRouter();
  bootstrap(() {
    return App(router: router);
  });
}
