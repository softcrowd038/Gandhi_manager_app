import 'dart:convert';

BikeModels bikeModelsFromJson(String str) =>
    BikeModels.fromJson(json.decode(str));

String bikeModelsToJson(BikeModels data) => json.encode(data.toJson());

class BikeModels {
  String? status;
  int? results;
  Data? data;

  BikeModels({
    this.status,
    this.results,
    this.data,
  });

  factory BikeModels.fromJson(Map<String, dynamic> json) => BikeModels(
        status: json["status"],
        results: json["results"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "results": results,
        "data": data?.toJson(),
      };
}

class Data {
  List<Model> models;

  Data({
    required this.models,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        models: json["models"] != null
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
        id: json["_id"]?.toString(),
        modelName: json["model_name"]?.toString(),
        prices: json["prices"] != null
            ? List<Price>.from(json["prices"].map((x) => Price.fromJson(x)))
            : [],
        createdAt: json["createdAt"] != null
            ? DateTime.tryParse(json["createdAt"])
            : null,
        v: json["__v"],
        modelId: json["id"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "model_name": modelName,
        "prices": List<dynamic>.from(prices.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
        "id": modelId,
      };
}

class Price {
  int? value;
  String? headerId;

  Price({
    this.value,
    this.headerId,
  });

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        value: json["value"],
        headerId: json["header_id"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "value": value,
        "header_id": headerId,
      };
}
