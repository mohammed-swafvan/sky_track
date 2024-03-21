part of 'home_bloc.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeSuccessState extends HomeState {
  final List<UserModel> users;
  final AuthModel currentUser;

  HomeSuccessState({required this.users, required this.currentUser});
}

class HomeErrorState extends HomeState {
  final String message;

  HomeErrorState(this.message);
}
