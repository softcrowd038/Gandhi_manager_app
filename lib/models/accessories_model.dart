import 'package:gandhi_tvs/common/app_imports.dart';

AccessoriesModel accessoriesModelFromJson(String str) =>
    AccessoriesModel.fromJson(json.decode(str));

String accessoriesModelToJson(AccessoriesModel data) =>
    json.encode(data.toJson());

class AccessoriesModel {
  String? status;
  int? results;
  Data? data;

  AccessoriesModel({
    required this.status,
    required this.results,
    required this.data,
  });

  factory AccessoriesModel.fromJson(Map<String?, dynamic>? json) =>
      AccessoriesModel(
        status: json?["status"],
        results: json?["results"],
        data: Data.fromJson(json?["data"]),
      );

  Map<String?, dynamic>? toJson() => {
    "status": status,
    "results": results,
    "data": data?.toJson(),
  };
}

class Data {
  List<Accessory> accessories;

  Data({required this.accessories});

  factory Data.fromJson(Map<String?, dynamic>? json) => Data(
    accessories: List<Accessory>.from(
      json?["accessories"].map((x) => Accessory.fromJson(x)),
    ),
  );

  Map<String?, dynamic>? toJson() => {
    "accessories": List<dynamic>.from(accessories.map((x) => x.toJson())),
  };
}

class Accessory {
  String? id;
  String? name;
  String? description;
  int? price;
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
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.applicableModels,
    required this.partNumber,
    required this.partNumberStatus,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.applicableModelsDetails,
    required this.accessoryId,
  });

  factory Accessory.fromJson(Map<String?, dynamic>? json) => Accessory(
    id: json?["_id"],
    name: json?["name"],
    description: json?["description"],
    price: json?["price"],
    applicableModels: List<String>.from(
      json?["applicable_models"].map((x) => x),
    ),
    partNumber: json?["part_number"],
    partNumberStatus: json?["part_number_status"],
    status: json?["status"],
    createdBy: json?["createdBy"],
    createdAt: DateTime.parse(json?["createdAt"]),
    updatedAt: DateTime.parse(json?["updatedAt"]),
    v: json?["__v"],
    applicableModelsDetails: List<ApplicableModelsDetail>.from(
      json?["applicableModelsDetails"].map(
        (x) => ApplicableModelsDetail.fromJson(x),
      ),
    ),
    accessoryId: json?["id"],
  );

  Map<String?, dynamic>? toJson() => {
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
}

class ApplicableModelsDetail {
  String? modelName;
  String? type;
  String? id;

  ApplicableModelsDetail({
    required this.modelName,
    required this.type,
    required this.id,
  });

  factory ApplicableModelsDetail.fromJson(Map<String?, dynamic>? json) =>
      ApplicableModelsDetail(
        modelName: json?["model_name"],
        type: json?["type"],
        id: json?["id"],
      );

  Map<String?, dynamic>? toJson() => {
    "model_name": modelName,
    "type": type,
    "id": id,
  };
}
