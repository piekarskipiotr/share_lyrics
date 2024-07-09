part of 'share_lyrics_bloc.dart';

class ShareLyricsState extends Equatable {
  const ShareLyricsState({
    required this.lyricsWidgetKey,
    required this.shareSongLyrics,
    required this.quickShare,
    required this.quickSaveToGallery,
    this.status = ShareLyricsStateStatus.initial,
    this.error,
  });

  final GlobalKey lyricsWidgetKey;
  final ShareSongLyrics shareSongLyrics;
  final bool quickShare;
  final bool quickSaveToGallery;
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
      quickSaveToGallery: quickSaveToGallery,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [lyricsWidgetKey, shareSongLyrics, quickShare, quickSaveToGallery, status, error];
}
