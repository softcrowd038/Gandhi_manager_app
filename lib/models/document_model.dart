import 'package:gandhi_tvs/common/app_imports.dart';

DocumentModel documentModelFromJson(String str) =>
    DocumentModel.fromJson(json.decode(str));

String documentModelToJson(DocumentModel data) => json.encode(data.toJson());

class DocumentModel {
  bool? success;
  int? count;
  List<Datum> data;

  DocumentModel({
    required this.success,
    required this.count,
    required this.data,
  });

  factory DocumentModel.fromJson(Map<String?, dynamic>? json) => DocumentModel(
    success: json?["success"],
    count: json?["count"],
    data: List<Datum>.from(json?["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String?, dynamic>? toJson() => {
    "success": success,
    "count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? name;
  bool? isRequired;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    required this.id,
    required this.name,
    required this.isRequired,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String?, dynamic>? json) => Datum(
    id: json?["_id"],
    name: json?["name"],
    isRequired: json?["isRequired"],
    description: json?["description"],
    createdAt: DateTime.parse(json?["createdAt"]),
    updatedAt: DateTime.parse(json?["updatedAt"]),
    v: json?["__v"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "name": name,
    "isRequired": isRequired,
    "description": description,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
