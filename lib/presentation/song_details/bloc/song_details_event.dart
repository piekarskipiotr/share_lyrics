part of 'song_details_bloc.dart';

abstract class SongDetailsEvent extends Equatable {
  const SongDetailsEvent();
}

final class FetchSongData extends SongDetailsEvent {
  const FetchSongData();

  @override
  List<Object?> get props => [];
}

final class SelectLine extends SongDetailsEvent {
  const SelectLine({required this.lyric});

  final Lyric lyric;

  @override
  List<Object?> get props => [lyric];
}
