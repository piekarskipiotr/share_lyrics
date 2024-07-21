import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:share_lyrics/resources/resources.dart';

void main() {
  test('sign_in_icons assets test', () {
    expect(File(SignInIcons.appleIcon).existsSync(), isTrue);
    expect(File(SignInIcons.googleIcon).existsSync(), isTrue);
  });
}
