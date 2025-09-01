// part "usermodel.g.dart";
// class Usermodel {
//   final String id;
//   final String userName;
//   final String email;
//   final String phoneNumber;
//   final String accessToken;
//   final String refreshToken;

//   Usermodel({
//     required this.id,
//     required this.userName,
//     required this.email,
//     required this.phoneNumber,
//     required this.accessToken,
//     required this.refreshToken,
//   });

//   factory Usermodel.fromJson(Map<String, dynamic> json) {
//     return Usermodel(
//       id: json['id'],
//       userName: json['userName'],
//       email: json['email'],
//       phoneNumber: json['phoneNumber'],
//       accessToken: json['access_token'],
//       refreshToken: json['refresh_token'],
//     );
//   }
// }

import 'package:hive_flutter/adapters.dart';

part "user_model.g.dart";

@HiveType(typeId: 1)
class UserModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  String userName;
  @HiveField(2)
  String email;
  @HiveField(3)
  String phoneNumber;
  @HiveField(4)
  String accessToken;
  @HiveField(5)
  String refreshToken;

  UserModel({
    required this.id,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.accessToken,
    required this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'].toString(),
      userName: json['user']['userName'],
      email: json['user']['email'],
      phoneNumber: json['user']['phoneNumber'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }
}
