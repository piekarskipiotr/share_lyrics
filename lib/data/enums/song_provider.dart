import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:share_lyrics/design_system/design_system.dart';
import 'package:share_lyrics/resources/resources.dart';

enum SongProvider {
  @JsonValue('youtube')
  youtube,
  @JsonValue('spotify')
  spotify,
  @JsonValue('soundcloud')
  soundcloud;

  String get name => switch (this) {
        SongProvider.youtube => 'YouTube',
        SongProvider.spotify => 'Spotify',
        SongProvider.soundcloud => 'Soundcloud',
      };

  String get logo => switch (this) {
        SongProvider.youtube => SongMediaIcons.youtubeIcon,
        SongProvider.spotify => SongMediaIcons.spotifyIcon,
        SongProvider.soundcloud => SongMediaIcons.soundcloudIcon,
      };

  Color get buttonBackgroundColor => switch (this) {
        SongProvider.youtube => const Color(0xFFFF0000),
        SongProvider.spotify => const Color(0xFF1ED860),
        SongProvider.soundcloud => const Color(0xFFFF5500),
      };

  Color get buttonTextColor => AppColors.white;

  ColorFilter? get logoColorFilter => const ColorFilter.mode(
        Colors.white,
        BlendMode.srcIn,
      );
}
