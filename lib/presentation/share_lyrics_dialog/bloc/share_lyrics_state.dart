part of 'share_lyrics_bloc.dart';

class ShareLyricsState extends Equatable {
  const ShareLyricsState({
    required this.lyricsWidgetKey,
    required this.shareSongLyrics,
    required this.quickShare,
    this.status = ShareLyricsStateStatus.initial,
    this.error,
  });

  final GlobalKey lyricsWidgetKey;
  final ShareSongLyrics shareSongLyrics;
  final bool quickShare;
  final ShareLyricsStateStatus status;
  final String? error;

  ShareLyricsState copyWith({
    ShareLyricsStateStatus? status,
    String? error,
  }) {
    return ShareLyricsState(
      lyricsWidgetKey: lyricsWidgetKey,
      shareSongLyrics: shareSongLyrics,
      quickShare: quickShare,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [lyricsWidgetKey, shareSongLyrics, quickShare, status, error];
}
