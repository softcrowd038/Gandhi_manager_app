// ignore_for_file: constant_identifier_names

import 'package:gandhi_tvs/common/app_imports.dart';

ModelHeaders modelHeadersFromJson(String str) =>
    ModelHeaders.fromJson(json.decode(str));

String modelHeadersToJson(ModelHeaders data) => json.encode(data.toJson());

class ModelHeaders {
  String? status;
  Data? data;

  ModelHeaders({required this.status, required this.data});

  factory ModelHeaders.fromJson(Map<String?, dynamic>? json) => ModelHeaders(
    status: json?["status"],
    data: json?["data"] != null ? Data.fromJson(json?["data"]) : null,
  );

  Map<String?, dynamic>? toJson() => {"status": status, "data": data?.toJson()};
}

class Data {
  Model model;

  Data({required this.model});

  factory Data.fromJson(Map<String?, dynamic>? json) => Data(
    model: json?["model"] != null
        ? Model.fromJson(json?["model"])
        : Model(id: null, modelName: null, prices: [], createdAt: null),
  );

  Map<String?, dynamic>? toJson() => {"model": model.toJson()};
}

class Model {
  String? id;
  String? modelName;
  List<Price> prices;
  DateTime? createdAt;

  Model({
    required this.id,
    required this.modelName,
    required this.prices,
    required this.createdAt,
  });

  factory Model.fromJson(Map<String?, dynamic>? json) => Model(
    id: json?["_id"],
    modelName: json?["model_name"],
    prices: List<Price>.from(
      (json?["prices"] ?? []).map((x) => Price.fromJson(x)),
    ),
    createdAt: json?["createdAt"] != null
        ? DateTime.parse(json!["createdAt"])
        : null,
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "model_name": modelName,
    "prices": List<dynamic>.from(prices.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
  };
}

class Price {
  int? value;
  String? headerId;
  String? headerKey;
  CategoryKey? categoryKey;
  int? priority;
  bool? isMandatory;
  bool? isDiscount;
  Metadata? metadata;
  BranchId? branchId;
  BranchName? branchName;
  BranchCity? branchCity;

  Price({
    required this.value,
    required this.headerId,
    required this.headerKey,
    required this.categoryKey,
    required this.priority,
    required this.isMandatory,
    required this.isDiscount,
    required this.metadata,
    required this.branchId,
    required this.branchName,
    required this.branchCity,
  });

  factory Price.fromJson(Map<String?, dynamic>? json) => Price(
    value: json?["value"],
    headerId: json?["header_id"],
    headerKey: json?["header_key"],
    categoryKey: categoryKeyValues.map?[json?["category_key"]],
    priority: json?["priority"],
    isMandatory: json?["is_mandatory"],
    isDiscount: json?["is_discount"],
    metadata: json?["metadata"] != null
        ? Metadata.fromJson(json?["metadata"])
        : null,
    branchId: branchIdValues.map?[json?["branch_id"]],
    branchName: branchNameValues.map?[json?["branch_name"]],
    branchCity: branchCityValues.map?[json?["branch_city"]],
  );

  Map<String?, dynamic>? toJson() => {
    "value": value,
    "header_id": headerId,
    "header_key": headerKey,
    "category_key": categoryKeyValues.reverse?[categoryKey],
    "priority": priority,
    "is_mandatory": isMandatory,
    "is_discount": isDiscount,
    "metadata": metadata?.toJson(),
    "branch_id": branchIdValues.reverse?[branchId],
    "branch_name": branchNameValues.reverse?[branchName],
    "branch_city": branchCityValues.reverse?[branchCity],
  };
}

enum BranchCity { PUNE }

final branchCityValues = EnumValues({"Pune": BranchCity.PUNE});

enum BranchId { THE_685641_B4_A584_A450570_F20_AE }

final branchIdValues = EnumValues({
  "685641b4a584a450570f20ae": BranchId.THE_685641_B4_A584_A450570_F20_AE,
});

enum BranchName { CIDCO_NASHIK }

final branchNameValues = EnumValues({"Cidco Nashik": BranchName.CIDCO_NASHIK});

enum CategoryKey { ACCESORIES, ADD_O_NSERVICES, VEHICLE_PRICE }

final categoryKeyValues = EnumValues({
  "Accesories": CategoryKey.ACCESORIES,
  "AddONservices": CategoryKey.ADD_O_NSERVICES,
  "vehicle_price": CategoryKey.VEHICLE_PRICE,
});

class Metadata {
  int? pageNo;
  int? hsnCode;
  dynamic gstRate;

  Metadata({
    required this.pageNo,
    required this.hsnCode,
    required this.gstRate,
  });

  factory Metadata.fromJson(Map<String?, dynamic>? json) => Metadata(
    pageNo: int.tryParse(json?["page_no"]?.toString() ?? ""),
    hsnCode: int.tryParse(json?["hsn_code"]?.toString() ?? ""),
    gstRate: json?["gst_rate"],
  );

  Map<String?, dynamic>? toJson() => {
    "page_no": pageNo,
    "hsn_code": hsnCode,
    "gst_rate": gstRate,
  };
}

class EnumValues<T> {
  Map<String?, T>? map;
  late Map<T?, String>? reverseMap;

  EnumValues(this.map);

  Map<T?, String>? get reverse {
    reverseMap = map?.map((k, v) => MapEntry(v, k ?? ""));
    return reverseMap;
  }
}
