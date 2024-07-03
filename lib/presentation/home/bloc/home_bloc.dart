import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:share_lyrics/presentation/feed/view/feed_page.dart';
import 'package:share_lyrics/presentation/search/view/search_page.dart';
import 'package:share_lyrics/services/search_service/search_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required SearchService searchService})
      : _searchService = searchService,
        super(const HomeState()) {
    on<ToggleSearchPage>(_onToggleSearchPage);
    on<ChangeSearchPhrase>(_onChangeSearchPhrase);
  }

  final SearchService _searchService;

  Future<void> _onToggleSearchPage(ToggleSearchPage event, Emitter<HomeState> emit) async {
    final showSearch = event.showSearch;
    emit(state.copyWith(showSearch: showSearch));
  }

  Future<void> _onChangeSearchPhrase(ChangeSearchPhrase event, Emitter<HomeState> emit) async {
    final phrase = event.phrase;
    _searchService.changeSearchPhrase(phrase);

    if (phrase.length <= 1) add(ToggleSearchPage(showSearch: phrase.isNotEmpty));
  }
}
