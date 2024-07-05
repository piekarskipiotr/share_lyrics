part of 'song_details_bloc.dart';

class SongDetailsState extends Equatable {
  const SongDetailsState({
    required this.song,
    this.status = SongDetailsStateStatus.initial,
    this.lyrics,
    this.showTitleInAppBar = false,
    this.error,
  });

  final SongDetailsStateStatus status;
  final Song song;
  final List<Lyric>? lyrics;
  final bool showTitleInAppBar;
  final String? error;

  SongDetailsState copyWith({
    SongDetailsStateStatus? status,
    Song? song,
    List<Lyric>? lyrics,
    bool? showTitleInAppBar,
    String? error,
  }) {
    return SongDetailsState(
      status: status ?? this.status,
      song: song ?? this.song,
      lyrics: lyrics ?? this.lyrics,
      showTitleInAppBar: showTitleInAppBar ?? this.showTitleInAppBar,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, song, lyrics, showTitleInAppBar, error];
}
