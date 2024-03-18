import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:random_string/random_string.dart';
import 'package:sky_track/domain/user/models/user_model.dart';
import 'package:sky_track/domain/user/user_service.dart';

class FirebaseUserRepository implements UserService {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('created_users');

  @override
  Stream<QuerySnapshot<Object?>> getUsers() {
    return collection.snapshots();
  }

  @override
  Future<UserModel> createUser(String firstName, String lastName, String email, String city) async {
    try {
      String id = randomNumeric(12);
      UserModel createdUser = UserModel(
        id: id,
        firstName: firstName,
        lastName: lastName,
        email: email,
        city: city,
      );
      await collection.doc(id).set(createdUser.toDocument());
      return createdUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(String? id) async {
    if (id == null) {
      throw ArgumentError('User ID cannot be null');
    }
    try {
      await collection.doc(id).delete();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
