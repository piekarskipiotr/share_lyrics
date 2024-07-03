import 'dart:async';

class SearchService {
  final _controller = StreamController<String>.broadcast();

  Stream<String> get phrase async* {
    yield* _controller.stream;
  }

  void changeSearchPhrase(String phrase) {
    _controller.add(phrase);
  }
}
