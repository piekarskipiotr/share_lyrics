import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' show parse;

class GeniusLyricsWrapper {
  GeniusLyricsWrapper(this.jsonResponse);

  final String jsonResponse;

  List<String> getLyrics() {
    final document = parse(jsonResponse);
    final lyricsContainers = document.querySelectorAll('div[data-lyrics-container="true"]');
    final lines = <String>[];

    for (final container in lyricsContainers) {
      _processNode(container, lines);
    }

    return lines.map((line) => line.trim()).where((line) => line.isNotEmpty && !_isMetadataLine(line)).toList();
  }

  void _processNode(dom.Node node, List<String> lines) {
    if (node.nodeType == dom.Node.TEXT_NODE) {
      if (lines.isEmpty) {
        lines.add(node.text!.trim());
      } else {
        lines[lines.length - 1] += node.text!.trim();
      }
    } else if (node is dom.Element && node.localName == 'br') {
      lines.add('');
    } else if (node is dom.Element) {
      for (final child in node.nodes) {
        _processNode(child, lines);
      }
    }
  }

  bool _isMetadataLine(String line) {
    final metadataPattern = RegExp(r'^\[.*?\]$');
    return metadataPattern.hasMatch(line);
  }
}
