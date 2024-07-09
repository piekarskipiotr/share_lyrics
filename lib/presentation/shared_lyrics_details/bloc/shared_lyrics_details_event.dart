part of 'shared_lyrics_details_bloc.dart';

abstract class SharedLyricsDetailsEvent extends Equatable {
  const SharedLyricsDetailsEvent();
}

final class FetchSongData extends SharedLyricsDetailsEvent {
  const FetchSongData();

  @override
  List<Object?> get props => [];
}

final class DeleteSharedLyrics extends SharedLyricsDetailsEvent {
  const DeleteSharedLyrics();

  @override
  List<Object?> get props => [];
}

final class ChangeVisibilityOfTitleInAppBar extends SharedLyricsDetailsEvent {
  const ChangeVisibilityOfTitleInAppBar({required this.showTitleInAppBar});

  final bool showTitleInAppBar;

  @override
  List<Object?> get props => [showTitleInAppBar];
}
