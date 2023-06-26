// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Menus welcomeFromJson(String str) => Menus.fromJson(json.decode(str));

String welcomeToJson(Menus data) => json.encode(data.toJson());

class Menus {
  int statusCode;
  List<Data> datas;

  Menus({
    required this.statusCode,
    required this.datas,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
    statusCode: json["status_code"],
    datas: List<Data>.from(json["datas"].map((x) => Data.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status_code": statusCode,
    "datas": List<dynamic>.from(datas.map((x) => x.toJson())),
  };
}

class Data {
  int id;
  String nama;
  int harga;
  String tipe;
  String gambar;

  Data({
    required this.id,
    required this.nama,
    required this.harga,
    required this.tipe,
    required this.gambar,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    nama: json["nama"],
    harga: json["harga"],
    tipe: json["tipe"],
    gambar: json["gambar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama": nama,
    "harga": harga,
    "tipe": tipe,
    "gambar": gambar,
  };
}
