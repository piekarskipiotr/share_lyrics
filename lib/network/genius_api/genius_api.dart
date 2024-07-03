import 'dart:io';

import 'package:chopper/chopper.dart';

part 'genius_api.chopper.dart';

typedef Json = Map<String, dynamic>;

@ChopperApi()
abstract class GeniusApi extends ChopperService {
  static GeniusApi create(String baseUrl, {bool enableLogs = true}) {
    final client = ChopperClient(
      baseUrl: Uri.parse(baseUrl),
      interceptors: [
        const HeadersInterceptor({
          HttpHeaders.authorizationHeader: 'Bearer FU8n0PzlVEumcQCdkrrhwLX1jTc30BzOvZtcSMynsmIFA3uElWXChEaO1ntmObCn',
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
