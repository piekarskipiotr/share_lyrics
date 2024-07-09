part of 'shared_lyrics_details_bloc.dart';

class SharedLyricsDetailsState extends Equatable {
  const SharedLyricsDetailsState({
    required this.sharedLyrics,
    this.status = SharedLyricsDetailsStateStatus.initial,
    this.showTitleInAppBar = false,
    this.error,
  });

  final SharedLyricsDetailsStateStatus status;
  final SharedLyrics sharedLyrics;
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
      showTitleInAppBar: showTitleInAppBar ?? this.showTitleInAppBar,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, sharedLyrics, showTitleInAppBar, error];
}
