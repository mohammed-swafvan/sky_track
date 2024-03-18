import 'package:bloc/bloc.dart';
import 'package:sky_track/domain/user/models/user_model.dart';
import 'package:sky_track/domain/user/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserService? userService;
  UserBloc({this.userService}) : super(UserInitial()) {
    on<CreateUserEvent>(_handleCreateUserEvent);
    on<DeleteUserEvent>(_handleDeleteUserEvent);
  }

  Future<void> _handleCreateUserEvent(CreateUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingState());
    try {
      await userService!.createUser(
        event.firstName,
        event.lastName,
        event.email,
        event.city,
      );
    } catch (e) {
      emit(ErrorState('Failed to create user: $e'));
    }
  }

  Future<void> _handleDeleteUserEvent(DeleteUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingState());
    try {
      if (userService != null && event.id != null) {
        await userService!.deleteUser(event.id!);
      } else {
        throw Exception('userService or event.id is null');
      }
    } catch (e) {
      emit(ErrorState('Failed to delete user: $e'));
    }
  }
}
