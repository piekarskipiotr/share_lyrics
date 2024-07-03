import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/utils/wrappers/genius_wrappers/genius_wrappers.dart';

class GeniusSongDetailsWrapper {
  GeniusSongDetailsWrapper(this.jsonResponse);

  final Map<String, dynamic>? jsonResponse;

  Song getSongDetails() {
    final response = jsonResponse?['response'] as Json;
    final songJson = response['song'] as Json;
    final song = Song.fromJson(songJson);
    return song;
  }
}
