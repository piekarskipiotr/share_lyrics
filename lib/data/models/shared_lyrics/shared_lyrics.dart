import 'package:json_annotation/json_annotation.dart';
import 'package:share_lyrics/data/models/models.dart';

part 'shared_lyrics.g.dart';

@JsonSerializable()
class SharedLyrics {
  const SharedLyrics({
    required this.lyrics,
    required this.song,
    this.userUUID,
    this.createdAt,
  });

  factory SharedLyrics.local({required List<String> lyrics, required Song song}) {
    return SharedLyrics(
      lyrics: lyrics,
      song: song,
    );
  }

  factory SharedLyrics.fromJson(Map<String, dynamic> json) => _$SharedLyricsFromJson(json);

  Map<String, dynamic> toJson() => _$SharedLyricsToJson(this);

  SharedLyrics updateLocalToFirestore({required String userUUID, required DateTime createdAt}) {
    return SharedLyrics(
      lyrics: lyrics,
      song: song,
      userUUID: userUUID,
      createdAt: createdAt,
    );
  }

  final List<String> lyrics;
  final Song song;
  final String? userUUID;
  final DateTime? createdAt;

  @override
  String toString() {
    return 'SharedLyrics{lyrics: $lyrics, song: $song, userUUID: $userUUID, createdAt: $createdAt}';
  }
}
