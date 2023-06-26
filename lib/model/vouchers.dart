// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Voucher welcomeFromJson(String str) => Voucher.fromJson(json.decode(str));

String welcomeToJson(Voucher data) => json.encode(data.toJson());

class Voucher {
  int statusCode;
  List<DataVoucher> datas;

  Voucher({
    required this.statusCode,
    required this.datas,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
    statusCode: json["status_code"],
    datas: List<DataVoucher>.from(json["datas"].map((x) => DataVoucher.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "datas": List<dynamic>.from(datas.map((x) => x.toJson())),
  };
}

class DataVoucher {
  int id;
  String kode;
  String gambar;
  int nominal;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  DataVoucher({
    required this.id,
    required this.kode,
    required this.gambar,
    required this.nominal,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DataVoucher.fromJson(Map<String, dynamic> json) => DataVoucher(
    id: json["id"],
    kode: json["kode"],
    gambar: json["gambar"],
    nominal: json["nominal"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "kode": kode,
    "gambar": gambar,
    "nominal": nominal,
    "status": status,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
