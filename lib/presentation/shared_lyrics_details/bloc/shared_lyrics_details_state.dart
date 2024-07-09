part of 'shared_lyrics_details_bloc.dart';

class SharedLyricsDetailsState extends Equatable {
  const SharedLyricsDetailsState({
    required this.sharedLyrics,
    this.status = SharedLyricsDetailsStateStatus.initial,
    this.songMedia,
    this.showTitleInAppBar = false,
    this.error,
  });

  final SharedLyricsDetailsStateStatus status;
  final SharedLyrics sharedLyrics;
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
      sharedLyrics: sharedLyrics,
      status: status ?? this.status,
      songMedia: songMedia ?? this.songMedia,
      showTitleInAppBar: showTitleInAppBar ?? this.showTitleInAppBar,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, sharedLyrics, songMedia, showTitleInAppBar, error];
}
