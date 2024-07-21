import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:share_lyrics/resources/resources.dart';

void main() {
  test('song_media_icons assets test', () {
    expect(File(SongMediaIcons.soundcloudIcon).existsSync(), isTrue);
    expect(File(SongMediaIcons.spotifyIcon).existsSync(), isTrue);
    expect(File(SongMediaIcons.youtubeIcon).existsSync(), isTrue);
  });
}
