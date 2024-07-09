import 'package:json_annotation/json_annotation.dart';

part 'share_song_lyrics.g.dart';

@JsonSerializable()
class ShareSongLyrics {
  const ShareSongLyrics({
    required this.id,
    required this.title,
    required this.artist,
    required this.image,
    required this.lyrics,
    this.userUUID,
    this.createdAt,
  });

  factory ShareSongLyrics.local({
    required int id,
    required String title,
    required String artist,
    required String? image,
    required List<String> lyrics,
  }) {
    return ShareSongLyrics(
      id: id,
      title: title,
      artist: artist,
      image: image,
      lyrics: lyrics,
    );
  }

  factory ShareSongLyrics.fromJson(Map<String, dynamic> json) => _$ShareSongLyricsFromJson(json);

  Map<String, dynamic> toJson() => _$ShareSongLyricsToJson(this);

  ShareSongLyrics updateLocalToFirestore({required String userUUID, required DateTime createdAt}) {
    return ShareSongLyrics(
      id: id,
      title: title,
      artist: artist,
      image: image,
      lyrics: lyrics,
      userUUID: userUUID,
      createdAt: createdAt,
    );
  }

  final int id;
  final String title;
  final String artist;
  final String? image;
  final List<String> lyrics;
  final String? userUUID;
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ShareSongLyrics{id: $id, title: $title, artist: $artist, image: $image, lyrics: $lyrics, userUUID: $userUUID, createdAt: $createdAt}';
  }
}
