part of 'user_bloc.dart';

sealed class UserState {}

final class UserInitial extends UserState {}

class LoadingState extends UserState {}

class SuccessState extends UserState {
  final List<UserModel> users;

  SuccessState(this.users);
}

class ErrorState extends UserState {
  final String message;

  ErrorState(this.message);
}
