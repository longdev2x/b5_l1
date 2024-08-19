import 'package:uuid/uuid.dart';

class UserEntity {
  final String uid;
  final String email;
  final String? avatar;

  UserEntity({
    String? uid,
    required this.email,
    this.avatar,
  }) : uid = uid ?? const Uuid().v4();

  UserEntity copyWith({String? avatar}) => UserEntity(
        uid: uid,
        email: email,
        avatar: avatar ?? this.avatar,
      );

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
    uid: json['uid'],
    email: json['email'],
    avatar: json['avatar']);

  Map<String, dynamic> toJson() => {
    'uid' : uid,
    'email' : email,
    'avatar' : avatar,
  };
}
