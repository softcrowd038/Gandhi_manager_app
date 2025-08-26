// ignore_for_file: constant_identifier_names

import 'package:gandhi_tvs/common/app_imports.dart';

AllQuotationModel allQuotationModelFromJson(String str) =>
    AllQuotationModel.fromJson(json.decode(str));

String allQuotationModelToJson(AllQuotationModel data) =>
    json.encode(data.toJson());

class AllQuotationModel {
  String? status;
  int? results;
  Data? data;

  AllQuotationModel({
    required this.status,
    required this.results,
    required this.data,
  });

  factory AllQuotationModel.fromJson(Map<String?, dynamic>? json) =>
      AllQuotationModel(
        status: json?["status"],
        results: json?["results"],
        data: json?["data"] != null ? Data.fromJson(json!["data"]) : null,
      );

  Map<String?, dynamic>? toJson() => {
    "status": status,
    "results": results,
    "data": data?.toJson(),
  };
}

class Data {
  List<Quotation> quotations;

  Data({required this.quotations});

  factory Data.fromJson(Map<String?, dynamic>? json) => Data(
    quotations: List<Quotation>.from(
      json?["quotations"].map((x) => Quotation.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "quotations": List<dynamic>.from(quotations.map((x) => x.toJson())),
  };
}

class Quotation {
  String? id;
  String? customerId;
  List<Model> models;
  ModelId? baseModelId;
  ModelName? baseModelName;
  DateTime? expectedDeliveryDate;
  bool? financeNeeded;
  Status? status;
  CreatedBy? createdBy;
  List<dynamic> termsConditions;
  String? quotationNumber;
  String? pdfUrl;
  DateTime? date;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  Customer? customer;
  Creator? creator;
  String? quotationId;

  Quotation({
    required this.id,
    required this.customerId,
    required this.models,
    required this.baseModelId,
    required this.baseModelName,
    required this.expectedDeliveryDate,
    required this.financeNeeded,
    required this.status,
    required this.createdBy,
    required this.termsConditions,
    required this.quotationNumber,
    required this.pdfUrl,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.customer,
    required this.creator,
    required this.quotationId,
  });

  factory Quotation.fromJson(Map<String?, dynamic>? json) => Quotation(
    id: json?["_id"],
    customerId: json?["customer_id"],
    models: json?["models"] != null
        ? List<Model>.from(json!["models"].map((x) => Model.fromJson(x)))
        : <Model>[],
    baseModelId:
        modelIdValues.map[json?["base_model_id"]] ??
        ModelId.THE_681_AF7846735_E18_D7968_A8_EE,
    baseModelName:
        modelNameValues.map[json?["base_model_name"]] ??
        ModelName.JUPITER_STD_OBD_II,
    expectedDeliveryDate: json?["expected_delivery_date"] != null
        ? DateTime.parse(json!["expected_delivery_date"])
        : null,
    financeNeeded: json?["finance_needed"],
    status: statusValues.map[json?["status"]] ?? Status.DRAFT,
    createdBy:
        createdByValues.map[json?["createdBy"]] ??
        CreatedBy.THE_681_AF0_DC6735_E18_D7968_A5_EF,
    termsConditions: json?["terms_conditions"] != null
        ? List<dynamic>.from(json!["terms_conditions"].map((x) => x))
        : <dynamic>[],
    quotationNumber: json?["quotation_number"],
    pdfUrl: json?['pdfUrl'],
    date: json?["date"] != null ? DateTime.parse(json!["date"]) : null,
    createdAt: json?["createdAt"] != null
        ? DateTime.parse(json!["createdAt"])
        : null,
    updatedAt: json?["updatedAt"] != null
        ? DateTime.parse(json!["updatedAt"])
        : null,
    v: json?["__v"],
    customer: json?["customer"] != null
        ? Customer.fromJson(json!["customer"])
        : null,
    creator: json?["creator"] != null
        ? Creator.fromJson(json!["creator"])
        : null,
    quotationId: json?["id"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "customer_id": customerId,
    "models": List<dynamic>.from(models.map((x) => x.toJson())),
    "base_model_id": modelIdValues.reverse[baseModelId],
    "base_model_name": modelNameValues.reverse[baseModelName],
    "expected_delivery_date": expectedDeliveryDate?.toIso8601String(),
    "finance_needed": financeNeeded,
    "status": statusValues.reverse[status],
    "createdBy": createdByValues.reverse[createdBy],
    "terms_conditions": List<dynamic>.from(termsConditions.map((x) => x)),
    "quotation_number": quotationNumber,
    "pdfUrl": pdfUrl,
    "date": date?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "customer": customer?.toJson(),
    "creator": creator?.toJson(),
    "id": quotationId,
  };
}

enum ModelId {
  THE_681_AF7846735_E18_D7968_A8_EE,
  THE_681_AF7846735_E18_D7968_A8_F1,
  THE_681_AF7846735_E18_D7968_A8_F4,
  THE_681_AF7846735_E18_D7968_A8_F7,
  THE_681_AF7846735_E18_D7968_A8_FA,
  THE_681_AF7846735_E18_D7968_A8_FD,
  THE_681_AF7846735_E18_D7968_A900,
  THE_681_AF7846735_E18_D7968_A903,
}

final modelIdValues = EnumValues({
  "681af7846735e18d7968a8ee": ModelId.THE_681_AF7846735_E18_D7968_A8_EE,
  "681af7846735e18d7968a8f1": ModelId.THE_681_AF7846735_E18_D7968_A8_F1,
  "681af7846735e18d7968a8f4": ModelId.THE_681_AF7846735_E18_D7968_A8_F4,
  "681af7846735e18d7968a8f7": ModelId.THE_681_AF7846735_E18_D7968_A8_F7,
  "681af7846735e18d7968a8fa": ModelId.THE_681_AF7846735_E18_D7968_A8_FA,
  "681af7846735e18d7968a8fd": ModelId.THE_681_AF7846735_E18_D7968_A8_FD,
  "681af7846735e18d7968a900": ModelId.THE_681_AF7846735_E18_D7968_A900,
  "681af7846735e18d7968a903": ModelId.THE_681_AF7846735_E18_D7968_A903,
});

enum ModelName {
  JUPITER_STD_OBD_II,
  JUPITER_ZX_DISC_SMARTXONNECT,
  JUPITER_ZX_DRUM,
  NTORQ_125_DISC,
  NTORQ_125_DRUM,
  NTORQ_125_RACE_EDITION,
  XL_100_COMFORT_KICKSTART_OBD_II,
  XL_100_HEAVY_DUTY_KICKSTART_OBD_II,
}

final modelNameValues = EnumValues({
  "JUPITER STD OBD II": ModelName.JUPITER_STD_OBD_II,
  "JUPITER ZX DISC SMARTXONNECT": ModelName.JUPITER_ZX_DISC_SMARTXONNECT,
  "JUPITER ZX DRUM": ModelName.JUPITER_ZX_DRUM,
  "NTORQ 125 DISC": ModelName.NTORQ_125_DISC,
  "NTORQ 125 DRUM": ModelName.NTORQ_125_DRUM,
  "NTORQ 125 RACE EDITION": ModelName.NTORQ_125_RACE_EDITION,
  "XL 100 COMFORT KICKSTART OBD II": ModelName.XL_100_COMFORT_KICKSTART_OBD_II,
  "XL 100 HEAVY DUTY KICKSTART OBD II":
      ModelName.XL_100_HEAVY_DUTY_KICKSTART_OBD_II,
});

enum CreatedBy { THE_681_AF0_DC6735_E18_D7968_A5_EF }

final createdByValues = EnumValues({
  "681af0dc6735e18d7968a5ef": CreatedBy.THE_681_AF0_DC6735_E18_D7968_A5_EF,
});

class Creator {
  CreatedBy? id;
  CreatedBy? creatorId;

  Creator({required this.id, required this.creatorId});

  factory Creator.fromJson(Map<String?, dynamic>? json) => Creator(
    id:
        createdByValues.map[json?["_id"]] ??
        CreatedBy.THE_681_AF0_DC6735_E18_D7968_A5_EF,
    creatorId:
        createdByValues.map[json?["id"]] ??
        CreatedBy.THE_681_AF0_DC6735_E18_D7968_A5_EF,
  );

  Map<String?, dynamic>? toJson() => {
    "_id": createdByValues.reverse[id],
    "id": createdByValues.reverse[creatorId],
  };
}

class Customer {
  String? id;
  String? name;
  String? mobile1;
  String? customerId;

  Customer({
    required this.id,
    required this.name,
    required this.mobile1,
    required this.customerId,
  });

  factory Customer.fromJson(Map<String?, dynamic>? json) => Customer(
    id: json?["_id"],
    name: json?["name"],
    mobile1: json?["mobile1"],
    customerId: json?["id"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "name": name,
    "mobile1": mobile1,
    "id": customerId,
  };
}

class Model {
  ModelId? modelId;
  ModelName? modelName;
  int? basePrice;

  Model({
    required this.modelId,
    required this.modelName,
    required this.basePrice,
  });

  factory Model.fromJson(Map<String?, dynamic>? json) => Model(
    modelId:
        modelIdValues.map[json?["model_id"]] ??
        ModelId.THE_681_AF7846735_E18_D7968_A8_EE,
    modelName:
        modelNameValues.map[json?["model_name"]] ??
        ModelName.JUPITER_STD_OBD_II,
    basePrice: json?["base_price"],
  );

  Map<String?, dynamic>? toJson() => {
    "model_id": modelIdValues.reverse[modelId],
    "model_name": modelNameValues.reverse[modelName],
    "base_price": basePrice,
  };
}

enum Status { DRAFT }

final statusValues = EnumValues({"draft": Status.DRAFT});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
