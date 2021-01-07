import 'dart:convert';

WordpressResponse wordpressResponseFromJson(String str) =>
    WordpressResponse.fromJson(json.decode(str));

class WordpressResponse {
  WordpressResponse({
    this.success,
    this.statusCode,
    this.code,
    this.message,
    this.data,
  });

  bool success;
  int statusCode;
  dynamic code;
  String message;
  Data data;

  factory WordpressResponse.fromJson(Map<String, dynamic> json) =>
      WordpressResponse(
        success: json["success"] ?? null,
        statusCode: json["statusCode"] ?? null,
        code: json["code"] ?? null,
        message: json["message"] ?? null,
        data: Data.fromJson(
            json["data"] is Map<String, dynamic> ? json["data"] : null),
      );
}

class Data {
  Data(
      {this.token,
      this.id,
      this.email,
      this.nicename,
      this.firstName,
      this.lastName,
      this.displayName,
      this.status});

  String token;
  int id;
  int status;
  String email;
  String nicename;
  String firstName;
  String lastName;
  String displayName;

  factory Data.fromJson(Map<String, dynamic> json) => json != null
      ? Data(
          token: json["token"],
          id: json["id"],
          status: json["status"],
          email: json["email"],
          nicename: json["nicename"],
          firstName: json["firstName"],
          lastName: json["lastName"],
          displayName: json["displayName"],
        )
      : null;
}
