import 'package:json_annotation/json_annotation.dart';

enum SongProvider {
  @JsonValue('youtube')
  youtube,
  @JsonValue('spotify')
  spotify,
  @JsonValue('soundcloud')
  soundcloud;

  String get providerName => switch (this) {
        SongProvider.youtube => 'YouTube',
        SongProvider.spotify => 'Spotify',
        SongProvider.soundcloud => 'Soundcloud',
      };
}
