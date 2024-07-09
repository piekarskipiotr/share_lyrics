part of 'share_lyrics_bloc.dart';

class ShareLyricsState extends Equatable {
  const ShareLyricsState({
    required this.lyricsWidgetKey,
    required this.sharedLyrics,
    required this.quickShare,
    required this.quickSaveToGallery,
    this.status = ShareLyricsStateStatus.initial,
    this.error,
  });

  final GlobalKey lyricsWidgetKey;
  final SharedLyrics sharedLyrics;
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
      sharedLyrics: sharedLyrics,
      quickShare: quickShare,
      quickSaveToGallery: quickSaveToGallery,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [lyricsWidgetKey, sharedLyrics, quickShare, quickSaveToGallery, status, error];
}
