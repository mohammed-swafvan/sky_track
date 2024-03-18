import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sky_track/domain/authentication/auth_service.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthService _authService;
  SignInBloc({
    required AuthService authService,
  })  : _authService = authService,
        super(SignInInitial()) {
    on<SignInRequired>((event, emit) async {
      emit(SignInProcess());
      try {
        await _authService.signIn(event.email, event.password);
        emit(SignInSuccess());
      } on FirebaseAuthException catch (e) {
        emit(SignInFailure(message: e.code));
      } catch (e) {
        emit(const SignInFailure());
      }
    });

    on<SignOutRequired>((event, emit) async {
      await _authService.logOut();
    });
  }
}
