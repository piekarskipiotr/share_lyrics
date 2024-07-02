part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
}

final class UpdateUserData extends SettingsEvent {
  const UpdateUserData();

  @override
  List<Object?> get props => [];
}

final class SignOut extends SettingsEvent {
  const SignOut();

  @override
  List<Object?> get props => [];
}

final class DeleteAccount extends SettingsEvent {
  const DeleteAccount();

  @override
  List<Object?> get props => [];
}
