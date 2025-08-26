import 'package:gandhi_tvs/common/app_imports.dart';

FinancerModel financerModelFromJson(String str) =>
    FinancerModel.fromJson(json.decode(str));

String financerModelToJson(FinancerModel data) => json.encode(data.toJson());

class FinancerModel {
  bool? success;
  List<Datum> data;

  FinancerModel({required this.success, required this.data});

  factory FinancerModel.fromJson(Map<String?, dynamic>? json) => FinancerModel(
    success: json?["success"],
    data: List<Datum>.from(json?["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String?, dynamic>? toJson() => {
    "success": success,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? name;
  bool? isActive;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  CreatedByDetails? createdByDetails;
  String? datumId;

  Datum({
    required this.id,
    required this.name,
    required this.isActive,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.createdByDetails,
    required this.datumId,
  });

  factory Datum.fromJson(Map<String?, dynamic>? json) => Datum(
    id: json?["_id"],
    name: json?["name"],
    isActive: json?["is_active"],
    createdBy: json?["createdBy"],
    createdAt: DateTime.parse(json?["createdAt"]),
    updatedAt: DateTime.parse(json?["updatedAt"]),
    v: json?["__v"],
    createdByDetails: CreatedByDetails.fromJson(json?["createdByDetails"]),
    datumId: json?["id"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "name": name,
    "is_active": isActive,
    "createdBy": createdBy,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "createdByDetails": createdByDetails?.toJson(),
    "id": datumId,
  };
}

class CreatedByDetails {
  String? id;
  String? name;
  String? email;
  String? createdByDetailsId;

  CreatedByDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.createdByDetailsId,
  });

  factory CreatedByDetails.fromJson(Map<String?, dynamic>? json) =>
      CreatedByDetails(
        id: json?["_id"],
        name: json?["name"],
        email: json?["email"],
        createdByDetailsId: json?["id"],
      );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "id": createdByDetailsId,
  };
}
