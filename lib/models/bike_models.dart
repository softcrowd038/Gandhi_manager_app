import 'package:gandhi_tvs/common/app_imports.dart';

BikeModels bikeModelsFromJson(String str) =>
    BikeModels.fromJson(json.decode(str));

String bikeModelsToJson(BikeModels data) => json.encode(data.toJson());

class BikeModels {
  String? status;
  int? results;
  Data? data;

  BikeModels({this.status, this.results, this.data});

  factory BikeModels.fromJson(Map<String, dynamic> json) => BikeModels(
    status: _parseString(json["status"]),
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

  static String? _parseString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    return value.toString();
  }
}

class Data {
  List<Model> models;

  Data({required this.models});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    models: json["models"] != null && json["models"] is List
        ? List<Model>.from(json["models"].map((x) => Model.fromJson(x)))
        : [],
  );

  Map<String, dynamic> toJson() => {
    "models": List<dynamic>.from(models.map((x) => x.toJson())),
  };
}

class Model {
  String? id;
  String? modelName;
  List<Price> prices;
  DateTime? createdAt;
  int? v;
  String? modelId;

  Model({
    this.id,
    this.modelName,
    required this.prices,
    this.createdAt,
    this.v,
    this.modelId,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    id: _parseString(json["_id"]),
    modelName: _parseString(json["model_name"]),
    prices: json["prices"] != null && json["prices"] is List
        ? List<Price>.from(json["prices"].map((x) => Price.fromJson(x)))
        : [],
    createdAt: json["createdAt"] != null
        ? DateTime.tryParse(json["createdAt"].toString())
        : null,
    v: _parseInt(json["__v"]),
    modelId: _parseString(json["id"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "model_name": modelName,
    "prices": List<dynamic>.from(prices.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
    "__v": v,
    "id": modelId,
  };

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  static String? _parseString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    return value.toString();
  }
}

class Price {
  int? value;
  String? headerId;

  Price({this.value, this.headerId});

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    value: _parseInt(json["value"]),
    headerId: _parseString(json["header_id"]),
  );

  Map<String, dynamic> toJson() => {"value": value, "header_id": headerId};

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  static String? _parseString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    return value.toString();
  }
}
