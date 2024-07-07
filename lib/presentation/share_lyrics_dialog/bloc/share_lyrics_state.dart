part of 'share_lyrics_bloc.dart';

class ShareLyricsState extends Equatable {
  const ShareLyricsState({
    required this.lyricsWidgetKey,
    required this.shareSongLyrics,
    this.status = ShareLyricsStateStatus.initial,
    this.error,
  });

  final GlobalKey lyricsWidgetKey;
  final ShareSongLyrics shareSongLyrics;
  final ShareLyricsStateStatus status;
  final String? error;

  ShareLyricsState copyWith({
    ShareLyricsStateStatus? status,
    String? error,
  }) {
    return ShareLyricsState(
      lyricsWidgetKey: lyricsWidgetKey,
      shareSongLyrics: shareSongLyrics,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [lyricsWidgetKey, shareSongLyrics, status, error];
}
