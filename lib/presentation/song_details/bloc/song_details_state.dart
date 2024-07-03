part of 'song_details_bloc.dart';

class SongDetailsState extends Equatable {
  const SongDetailsState({
    required this.song,
    this.status = StateStatus.initial,
    this.lyrics,
    this.error,
  });

  final StateStatus status;
  final Song song;
  final List<String>? lyrics;
  final String? error;

  SongDetailsState copyWith({
    StateStatus? status,
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
