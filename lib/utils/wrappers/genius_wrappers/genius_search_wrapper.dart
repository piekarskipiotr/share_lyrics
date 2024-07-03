import 'package:share_lyrics/data/models/models.dart';
import 'package:share_lyrics/utils/wrappers/genius_wrappers/genius_wrappers.dart';

class GeniusSearchWrapper {
  GeniusSearchWrapper(this.jsonResponse);

  final Map<String, dynamic>? jsonResponse;

  List<Song> getSongs() {
    final response = jsonResponse?['response'] as Json;
    final hits = response['hits'] as List<dynamic>;
    final songs = hits.map((e) => Song.fromJson((e as Json)['result'] as Json)).toList();
    return songs;
  }
}
