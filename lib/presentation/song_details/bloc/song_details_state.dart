part of 'song_details_bloc.dart';

class SongDetailsState extends Equatable {
  const SongDetailsState({
    required this.song,
    this.status = SongDetailsStateStatus.initial,
    this.lyrics,
    this.error,
  });

  final SongDetailsStateStatus status;
  final Song song;
  final List<String>? lyrics;
  final String? error;

  SongDetailsState copyWith({
    SongDetailsStateStatus? status,
    Song? song,
    List<String>? lyrics,
    String? error,
  }) {
    return SongDetailsState(
      status: status ?? this.status,
      song: song ?? this.song,
      lyrics: lyrics ?? this.lyrics,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, song, lyrics, error];
}
