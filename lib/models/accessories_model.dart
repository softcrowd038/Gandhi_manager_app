import 'package:gandhi_tvs/common/app_imports.dart';

AccessoriesModel accessoriesModelFromJson(String str) =>
    AccessoriesModel.fromJson(json.decode(str));

String accessoriesModelToJson(AccessoriesModel data) =>
    json.encode(data.toJson());

class AccessoriesModel {
  String? status;
  int? results;
  Data? data;

  AccessoriesModel({this.status, this.results, this.data});

  factory AccessoriesModel.fromJson(Map<String, dynamic> json) =>
      AccessoriesModel(
        status: json["status"]?.toString(),
        results: _parseInt(json["results"]),
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "results": results,
    "data": data?.toJson(),
  };

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}

class Data {
  List<Accessory> accessories;

  Data({required this.accessories});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessories: List<Accessory>.from(
      (json["accessories"] as List<dynamic>?)?.map(
            (x) => Accessory.fromJson(x),
          ) ??
          [],
    ),
  );

  Map<String, dynamic> toJson() => {
    "accessories": List<dynamic>.from(accessories.map((x) => x.toJson())),
  };
}

class Accessory {
  String? id;
  String? name;
  String? description;
  double? price;
  List<String> applicableModels;
  String? partNumber;
  String? partNumberStatus;
  String? status;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<ApplicableModelsDetail> applicableModelsDetails;
  String? accessoryId;

  Accessory({
    this.id,
    this.name,
    this.description,
    this.price,
    required this.applicableModels,
    this.partNumber,
    this.partNumberStatus,
    this.status,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
    required this.applicableModelsDetails,
    this.accessoryId,
  });

  factory Accessory.fromJson(Map<String, dynamic> json) => Accessory(
    id: json["_id"]?.toString(),
    name: json["name"]?.toString(),
    description: json["description"]?.toString(),
    price: _parseDouble(json["price"]),
    applicableModels: List<String>.from(
      (json["applicable_models"] as List<dynamic>?)?.map((x) => x.toString()) ??
          [],
    ),
    partNumber: json["part_number"]?.toString(),
    partNumberStatus: json["part_number_status"]?.toString(),
    status: json["status"]?.toString(),
    createdBy: json["createdBy"]?.toString(),
    createdAt: _parseDateTime(json["createdAt"]),
    updatedAt: _parseDateTime(json["updatedAt"]),
    v: _parseInt(json["__v"]),
    applicableModelsDetails: List<ApplicableModelsDetail>.from(
      (json["applicableModelsDetails"] as List<dynamic>?)?.map(
            (x) => ApplicableModelsDetail.fromJson(x),
          ) ??
          [],
    ),
    accessoryId: json["id"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "price": price,
    "applicable_models": List<dynamic>.from(applicableModels.map((x) => x)),
    "part_number": partNumber,
    "part_number_status": partNumberStatus,
    "status": status,
    "createdBy": createdBy,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "applicableModelsDetails": List<dynamic>.from(
      applicableModelsDetails.map((x) => x.toJson()),
    ),
    "id": accessoryId,
  };

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}

class ApplicableModelsDetail {
  String? modelName;
  String? type;
  String? id;

  ApplicableModelsDetail({this.modelName, this.type, this.id});

  factory ApplicableModelsDetail.fromJson(Map<String, dynamic> json) =>
      ApplicableModelsDetail(
        modelName: json["model_name"]?.toString(),
        type: json["type"]?.toString(),
        id: json["id"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
    "model_name": modelName,
    "type": type,
    "id": id,
  };
}
