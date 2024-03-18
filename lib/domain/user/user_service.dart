import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/model.dart';

abstract class UserService {
  Stream<QuerySnapshot<Object?>> getUsers();

  Future<UserModel> createUser(String firstName, String lastName, String email, String city);

  Future<void> deleteUser(String id);
}
