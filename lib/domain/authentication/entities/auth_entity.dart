import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String userId;
  final String userEmail;

  const AuthEntity({
    required this.userId,
    required this.userEmail,
  });

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'userEmail': userEmail,
    };
  }

  static AuthEntity fromDocument(Map<String, dynamic> doc) {
    return AuthEntity(
      userId: doc['userId'],
      userEmail: doc['userEmail'],
    );
  }

  @override
  List<Object?> get props => [userId, userEmail];
}
