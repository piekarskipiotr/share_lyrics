import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:share_lyrics/presentation/feed/view/feed_page.dart';
import 'package:share_lyrics/presentation/search/view/search_page.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<ToggleSearchPage>(_onToggleSearchPage);
  }

  Future<void> _onToggleSearchPage(ToggleSearchPage event, Emitter<HomeState> emit) async {
    final showSearch = event.showSearch;
    emit(state.copyWith(showSearch: showSearch));
  }
}
