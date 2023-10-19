// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  bool status;
  int statusCode;
  String message;
  Data data;

  Welcome({
    required this.status,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        status: json["status"],
        statusCode: json["statusCode"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  get displayError => null;

  Map<String, dynamic> toJson() => {
        "status": status,
        "statusCode": statusCode,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  UserData userData;
  String accessToken;
  String ttl;
  int createdAt;

  Data({
    required this.userData,
    required this.accessToken,
    required this.ttl,
    required this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userData: UserData.fromJson(json["userData"]),
        accessToken: json["accessToken"],
        ttl: json["ttl"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "userData": userData.toJson(),
        "accessToken": accessToken,
        "ttl": ttl,
        "createdAt": createdAt,
      };
}

class UserData {
  int userId;
  String userName;
  String userDisplayName;

  UserData({
    required this.userId,
    required this.userName,
    required this.userDisplayName,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        userId: json["user_id"],
        userName: json["user_name"],
        userDisplayName: json["user_display_name"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_name": userName,
        "user_display_name": userDisplayName,
      };
}
