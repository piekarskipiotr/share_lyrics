part of 'share_lyrics_bloc.dart';

abstract class ShareLyricsEvent extends Equatable {
  const ShareLyricsEvent();
}

final class SaveNShareLyrics extends ShareLyricsEvent {
  const SaveNShareLyrics();

  @override
  List<Object?> get props => [];
}

final class SaveLyrics extends ShareLyricsEvent {
  const SaveLyrics();

  @override
  List<Object?> get props => [];
}