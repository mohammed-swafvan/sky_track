import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sky_track/domain/authentication/models/model.dart';
import 'package:sky_track/domain/authentication/models/auth_model.dart';
import 'package:sky_track/domain/authentication/auth_service.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthService _authService;

  SignUpBloc({
    required AuthService authService,
  })  : _authService = authService,
        super(SignUpInitial()) {
    on<SignUpRequired>((event, emit) async {
      emit(SignUpProcess());
      try {
        AuthModel user = await _authService.signUp(event.user, event.password);
        await _authService.setUserData(user);
        emit(SignUpSuccess());
      } on FirebaseAuthException catch (e) {
        emit(SignUpFailure(message: e.code));
      }
    });
  }
}
