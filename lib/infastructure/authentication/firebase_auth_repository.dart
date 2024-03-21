import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sky_track/domain/authentication/models/auth_model.dart';
import 'package:sky_track/domain/authentication/auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FirebaseAuthRepository implements AuthService {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

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

      await secureStorage.write(key: 'uid', value: credential.user!.uid);
      await secureStorage.write(key: 'email', value: newUser.userEmail);

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

      await secureStorage.write(key: 'uid', value: credential.user!.uid);
      await secureStorage.write(key: 'email', value: email);
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
      await secureStorage.deleteAll();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
