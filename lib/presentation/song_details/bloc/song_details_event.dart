part of 'song_details_bloc.dart';

abstract class SongDetailsEvent extends Equatable {
  const SongDetailsEvent();
}

final class FetchSongDetails extends SongDetailsEvent {
  const FetchSongDetails({required this.id});

  final int id;

  @override
  List<Object?> get props => [id];
}

final class FetchLyrics extends SongDetailsEvent {
  const FetchLyrics({required this.url});

  final String? url;

  @override
  List<Object?> get props => [url];
}

