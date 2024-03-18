import 'package:equatable/equatable.dart';
import 'package:sky_track/domain/authentication/entities/auth_entity.dart';

class AuthModel extends Equatable {
  final String userId;
  final String userEmail;

  const AuthModel({
    required this.userId,
    required this.userEmail,
  });

  static const empty = AuthModel(
    userId: '',
    userEmail: '',
  );

  AuthModel copyWith({
    String? userId,
    String? userEmail,
  }) {
    return AuthModel(
      userId: userId ?? this.userId,
      userEmail: userEmail ?? this.userEmail,
    );
  }

  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      userEmail: userEmail,
    );
  }

  static AuthModel fromEntity(AuthEntity entity) {
    return AuthModel(
      userId: entity.userId,
      userEmail: entity.userEmail,
    );
  }

  @override
  List<Object?> get props => [userId, userEmail];
}
