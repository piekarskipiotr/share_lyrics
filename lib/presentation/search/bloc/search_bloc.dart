import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/data/models/song/song.dart';
import 'package:share_lyrics/data/repositories/genius_repository/genius_repository.dart';
import 'package:share_lyrics/services/search_service/search_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required GeniusRepository geniusRepository, required SearchService searchService})
      : _geniusRepository = geniusRepository,
        _searchService = searchService,
        super(const SearchState()) {
    on<Search>(_onSearch);
    _phraseSubscription = _searchService.phrase.listen((phrase) => add(Search(phrase: phrase)));
  }

  final SearchService _searchService;
  final GeniusRepository _geniusRepository;
  late StreamSubscription<String> _phraseSubscription;

  Future<void> _onSearch(Search event, Emitter<SearchState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));
    await _geniusRepository.search(phrase: event.phrase).then((results) async {
      emit(state.copyWith(status: StateStatus.success, results: results));
    }).catchError((Object error, StackTrace stacktrace) async {
      log('GENIUS: FAILED TO SEARCH WITH PHRASE, error: $error \n\n $stacktrace');
      emit(state.copyWith(status: StateStatus.failure, error: error.toString()));
    });
  }

  @override
  Future<void> close() {
    _phraseSubscription.cancel();
    return super.close();
  }
}
