import 'dart:convert';

class Response {
  bool success;
  List<Datum> data;
  int status;
  String message;

  Response({
    this.success,
    this.data,
    this.status,
    this.message,
  });

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
        "message": message,
      };
}

class Datum {
  String uid;
  String nama;
  dynamic nohp;
  String email;
  String foto;
  String type;

  Datum({
    this.uid,
    this.nama,
    this.nohp,
    this.email,
    this.foto,
    this.type,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        uid: json["uid"],
        nama: json["nama"],
        nohp: json["nohp"],
        email: json["email"],
        foto: json["foto"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "nama": nama,
        "nohp": nohp,
        "email": email,
        "foto": foto,
        "type": type,
      };
}
