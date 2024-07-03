import 'package:html/parser.dart';

class GeniusLyricsWrapper {
  GeniusLyricsWrapper(this.jsonResponse);

  final String jsonResponse;

  List<String> getLyrics() {
    final document = parse(jsonResponse);
    final lyricsContainer = document.querySelector('div[class^="Lyrics__Container"]');
    final lyricsContainerItems = [...?lyricsContainer?.querySelectorAll('span')];
    final lines = <String>[];
    for (final element in lyricsContainerItems) {
      for (final node in element.nodes) {
        if (node.nodeType == 3) {
          lines.addAll(node.text!.trim().split('\n'));
        } else if (node.text?.contains('<br>') ?? false) {
          lines.add('');
        }
      }
    }

    return lines.map((line) => line.trim()).where((line) => line.isNotEmpty).toList();
  }
}
