import 'package:json_annotation/json_annotation.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/data/enums/song_provider.dart';

part 'song_media.g.dart';

@JsonSerializable()
class SongMedia {
  const SongMedia({
    required this.provider,
    required this.url,
  });

  factory SongMedia.fromJson(Map<String, dynamic> json) => _$SongMediaFromJson(json);

  Map<String, dynamic> toJson() => _$SongMediaToJson(this);

  final SongProvider provider;
  final String url;

  @override
  String toString() {
    return 'SongMedia{provider: $provider, url: $url}';
  }
}
