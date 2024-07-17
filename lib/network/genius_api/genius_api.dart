import 'dart:io';

import 'package:chopper/chopper.dart';

part 'genius_api.chopper.dart';

typedef Json = Map<String, dynamic>;

@ChopperApi()
abstract class GeniusApi extends ChopperService {
  static GeniusApi create(String baseUrl, String geniusApiKey, {bool enableLogs = true}) {
    final client = ChopperClient(
      baseUrl: Uri.parse(baseUrl),
      interceptors: [
        HeadersInterceptor({
          HttpHeaders.authorizationHeader: 'Bearer $geniusApiKey',
          HttpHeaders.hostHeader: 'api.genius.com',
          contentTypeKey: jsonHeaders,
        }),
        if (enableLogs) HttpLoggingInterceptor(),
      ],
      converter: const JsonConverter(),
      errorConverter: const JsonConverter(),
      services: [_$GeniusApi()],
    );

    return _$GeniusApi(client);
  }

  @Get(path: 'search/')
  Future<Response<Json>> search({@Query('q') required String phrase});

  @Get(path: 'songs/{id}')
  Future<Response<Json>> getSongDetails({@Path('id') required int id});
}
