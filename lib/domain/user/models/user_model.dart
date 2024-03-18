import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String city;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.city,
  });

  factory UserModel.fromDocument(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toDocument() => _$UserModelToJson(this);
}
