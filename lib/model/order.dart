// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Order welcomeFromJson(String str) => Order.fromJson(json.decode(str));

String welcomeToJson(Order data) => json.encode(data.toJson());

class Order {
  int statusCode;
  String message;

  Order({
    required this.statusCode,
    required this.message,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    statusCode: json["status_code"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "message": message,
  };
}
