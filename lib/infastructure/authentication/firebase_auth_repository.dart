import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sky_track/domain/authentication/models/auth_model.dart';
import 'package:sky_track/domain/authentication/auth_service.dart';

class FirebaseAuthRepository implements AuthService {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  FirebaseAuthRepository({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((user) {
      return user;
    });
  }

  @override
  Future<AuthModel> signUp(AuthModel newUser, String password) async {
    try {
      UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: newUser.userEmail,
        password: password,
      );

      newUser = newUser.copyWith(userId: credential.user!.uid);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', credential.user!.uid);
      await prefs.setString('email', newUser.userEmail);
      await prefs.setString('password', password);

      return newUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('uid', credential.user!.uid);
      await prefs.setString('email', email);
      await prefs.setString('password', password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> setUserData(AuthModel user) async {
    try {
      await userCollection.doc(user.userId).set(
            user.toEntity().toDocument(),
          );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
