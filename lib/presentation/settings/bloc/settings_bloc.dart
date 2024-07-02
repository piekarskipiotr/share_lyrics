import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:share_lyrics/data/enums/enums.dart';
import 'package:share_lyrics/services/auth_service/auth_service.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required AuthService authService})
      : _authService = authService,
        super(const SettingsState()) {
    on<UpdateUserData>(_onUpdateUserData);
    on<SignOut>(_onSignOut);
    on<DeleteAccount>(_onDeleteAccount);

    add(const UpdateUserData());
  }

  final AuthService _authService;

  Future<void> _onUpdateUserData(UpdateUserData event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));
    final user = _authService.currentUser;
    emit(state.copyWith(status: StateStatus.success, user: user));
  }

  Future<void> _onSignOut(SignOut event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));
    await _authService.signOut().then((_) async {
      emit(state.copyWith(status: StateStatus.success));
    }).catchError((Object error, StackTrace stacktrace) async {
      log('FAILED TO SIGN OUT, error: $error \n\n $stacktrace');
      emit(state.copyWith(status: StateStatus.failure, error: error.toString()));
    });
  }

  Future<void> _onDeleteAccount(DeleteAccount event, Emitter<SettingsState> emit) async {
    emit(state.copyWith(status: StateStatus.loading));
    await _authService.deleteAccount().then((_) async {
      emit(state.copyWith(status: StateStatus.success));
    }).catchError((Object error, StackTrace stacktrace) async {
      log('FAILED TO DELETE ACCOUNT, error: $error \n\n $stacktrace');
      emit(state.copyWith(status: StateStatus.failure, error: error.toString()));
    });
  }
}
