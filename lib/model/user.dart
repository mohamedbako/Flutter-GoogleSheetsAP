import 'package:flutter/material.dart';

class UserFields {
  static final String id = "ID";
  static final String name = "Name";
  static final String nickname = "Nickname";
  static final String email = "Email";
  static final String phone = "Phone";
  static final String experience = "Experience";
  static final String msg = "Message";

  static List<String> getFields() =>
      [id, name, nickname, phone, email, experience, msg];
}

class User {
  final int? id;
  final String name;
  final String nickname;
  final String phone;
  final String email;
  final bool experience;
  final String msg;

  const User(
      {this.id,
      required this.name,
      required this.nickname,
      required this.phone,
      required this.email,
      required this.experience,
      required this.msg});

  User copy({
    int? id,
    String? name,
    String? nickname,
    String? phone,
    String? email,
    bool? experience,
    String? msg,
  }) =>
      User(
          id: id ?? this.id,
          name: name ?? this.name,
          nickname: nickname ?? this.nickname,
          phone: phone ?? this.phone,
          email: email ?? this.email,
          experience: experience ?? this.experience,
          msg: msg ?? this.msg);

  Map<String, dynamic> toJson() => {
        UserFields.id: id,
        UserFields.name: name,
        UserFields.nickname: nickname,
        UserFields.phone: phone,
        UserFields.email: email,
        UserFields.experience: experience,
        UserFields.msg: msg,
      };
}
