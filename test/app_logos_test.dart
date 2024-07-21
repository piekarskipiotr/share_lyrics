import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:share_lyrics/resources/resources.dart';

void main() {
  test('app_logos assets test', () {
    expect(File(AppLogos.shareLyricsLogo).existsSync(), isTrue);
    expect(File(AppLogos.shareLyricsLogoVariant).existsSync(), isTrue);
  });
}
