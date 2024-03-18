import 'models/model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  Stream<User?> get user;

  Future<AuthModel> signUp(AuthModel user, String password);

  Future<void> setUserData(AuthModel user);

  Future<void> signIn(String email, String password);

  Future<void> logOut();

  Future<void> forgotPassword(String email);
}
