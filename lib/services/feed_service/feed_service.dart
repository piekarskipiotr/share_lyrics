import 'dart:async';

class FeedService {
  final _controller = StreamController<void>.broadcast();

  Stream<void> get onRefresh async* {
    yield* _controller.stream;
  }

  void refresh() {
    _controller.add(null);
  }
}
