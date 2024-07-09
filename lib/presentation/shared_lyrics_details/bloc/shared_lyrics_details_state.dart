part of 'shared_lyrics_details_bloc.dart';

class SharedLyricsDetailsState extends Equatable {
  const SharedLyricsDetailsState({
    required this.shareSongLyrics,
    this.status = SharedLyricsDetailsStateStatus.initial,
    this.songMedia,
    this.showTitleInAppBar = false,
    this.error,
  });

  final SharedLyricsDetailsStateStatus status;
  final ShareSongLyrics shareSongLyrics;
  final List<SongMedia>? songMedia;
  final bool showTitleInAppBar;
  final String? error;

  SharedLyricsDetailsState copyWith({
    SharedLyricsDetailsStateStatus? status,
    List<SongMedia>? songMedia,
    bool? showTitleInAppBar,
    String? error,
  }) {
    return SharedLyricsDetailsState(
      shareSongLyrics: shareSongLyrics,
      status: status ?? this.status,
      songMedia: songMedia ?? this.songMedia,
      showTitleInAppBar: showTitleInAppBar ?? this.showTitleInAppBar,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, shareSongLyrics, songMedia, showTitleInAppBar, error];
}
