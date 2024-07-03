import 'dart:developer';

import 'package:chopper/chopper.dart' hide Post;
import 'package:http/http.dart' as http;
import 'package:share_lyrics/data/models/song/song.dart';
import 'package:share_lyrics/network/genius_api/genius_api.dart';
import 'package:share_lyrics/utils/wrappers/genius_wrappers/genius_wrappers.dart';

class GeniusRepository {
  GeniusRepository(this._geniusApi);

  final GeniusApi _geniusApi;

  bool _isSuccessful<T>(Response<T> response, {bool hasBody = true}) {
    final isResponseSuccessful = response.isSuccessful;
    final bool isBodySuccessful;
    if (hasBody) {
      isBodySuccessful = response.bodyString.isNotEmpty;
    } else {
      isBodySuccessful = true;
    }

    return isResponseSuccessful && isBodySuccessful;
  }

  Future<List<Song>> search({required String phrase}) async {
    final response = await _geniusApi.search(phrase: phrase);
    if (_isSuccessful(response)) {
      final body = response.body;
      return GeniusSearchWrapper(body).getSongs();
    } else {
      log('${response.error}');
      throw Exception(response.error);
    }
  }

  Future<Song> getSongDetails({required int id}) async {
    final response = await _geniusApi.getSongDetails(id: id);
    if (_isSuccessful(response)) {
      return Song.fromJson(response.body!);
    } else {
      log('${response.error}');
      throw Exception(response.error);
    }
  }

  Future<List<String>> getSongLyrics({required String url}) async {
    final response = await http.get(Uri.parse(url));
    final isSuccessful = response.statusCode == 200;
    if (isSuccessful) {
      final body = response.body;
      return GeniusLyricsWrapper(body).getLyrics();
    } else {
      throw Exception('Failed to fetch song lyrics $url');
    }
  }
}
