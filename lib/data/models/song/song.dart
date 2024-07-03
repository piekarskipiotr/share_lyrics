import 'package:json_annotation/json_annotation.dart';

part 'song.g.dart';

@JsonSerializable()
class Song {
  const Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.image,
    required this.lyricsUrl,
  });

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);

  Map<String, dynamic> toJson() => _$SongToJson(this);

  final int id;
  final String title;
  @JsonKey(name: 'primary_artist_names')
  final String artist;
  @JsonKey(name: 'song_art_image_url')
  final String? image;
  @JsonKey(name: 'url')
  final String? lyricsUrl;

  @override
  String toString() {
    return 'Song{id: $id, title: $title, artist: $artist, image: $image, lyricsUrl: $lyricsUrl}';
  }
}
