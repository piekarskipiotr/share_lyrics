part of 'share_lyrics_bloc.dart';

class ShareLyricsState extends Equatable {
  const ShareLyricsState({
    required this.lyricsWidgetKey,
    required this.sharedLyrics,
    required this.mode,
    this.status = ShareLyricsStateStatus.initial,
    this.error,
  });

  final GlobalKey lyricsWidgetKey;
  final SharedLyrics sharedLyrics;
  final ShareLyricsDialogMode mode;
  final ShareLyricsStateStatus status;
  final String? error;

  ShareLyricsState copyWith({
    ShareLyricsStateStatus? status,
    String? error,
  }) {
    return ShareLyricsState(
      lyricsWidgetKey: lyricsWidgetKey,
      sharedLyrics: sharedLyrics,
      mode: mode,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [lyricsWidgetKey, sharedLyrics, mode, status, error];
}
