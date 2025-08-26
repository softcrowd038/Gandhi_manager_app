import 'package:gandhi_tvs/common/app_imports.dart';

ColorsModel colorsModelFromJson(String str) =>
    ColorsModel.fromJson(json.decode(str));

String colorsModelToJson(ColorsModel data) => json.encode(data.toJson());

class ColorsModel {
  String? status;
  Data? data;

  ColorsModel({required this.status, required this.data});

  factory ColorsModel.fromJson(Map<String?, dynamic>? json) =>
      ColorsModel(status: json?["status"], data: Data.fromJson(json?["data"]));

  Map<String?, dynamic>? toJson() => {"status": status, "data": data?.toJson()};
}

class Data {
  List<Color> colors;

  Data({required this.colors});

  factory Data.fromJson(Map<String?, dynamic>? json) => Data(
    colors: List<Color>.from(json?["colors"].map((x) => Color.fromJson(x))),
  );

  Map<String?, dynamic>? toJson() => {
    "colors": List<dynamic>.from(colors.map((x) => x.toJson())),
  };
}

class Color {
  String? name;
  String? hexCode;
  String? id;

  Color({required this.name, required this.hexCode, required this.id});

  factory Color.fromJson(Map<String?, dynamic>? json) =>
      Color(name: json?["name"], hexCode: json?["hex_code"], id: json?["id"]);

  Map<String?, dynamic>? toJson() => {
    "name": name,
    "hex_code": hexCode,
    "id": id,
  };
}
