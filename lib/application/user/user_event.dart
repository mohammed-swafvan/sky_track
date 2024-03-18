part of 'user_bloc.dart';

sealed class UserEvent {}

class CreateUserEvent extends UserEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String city;

  CreateUserEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.city,
  });
}

class DeleteUserEvent extends UserEvent {
  final String? id;

  DeleteUserEvent(this.id);
}
