class ShareSongLyrics {
  const ShareSongLyrics({
    required this.title,
    required this.artist,
    required this.image,
    required this.lyrics,
  });

  final String title;
  final String artist;
  final String? image;
  final List<String> lyrics;

  @override
  String toString() {
    return 'ShareSongLyrics{title: $title, artist: $artist, image: $image, lyrics: $lyrics}';
  }
}
