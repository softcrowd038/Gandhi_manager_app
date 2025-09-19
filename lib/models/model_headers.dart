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
    status: _parseString(json?["status"]),
    data: json?["data"] != null ? Data.fromJson(json?["data"]) : null,
  );

  Map<String?, dynamic>? toJson() => {"status": status, "data": data?.toJson()};

  static String? _parseString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    return value.toString();
  }
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
    id: _parseString(json?["_id"]),
    modelName: _parseString(json?["model_name"]),
    prices: json?["prices"] != null && json?["prices"] is List
        ? List<Price>.from(
            (json?["prices"] as List).map((x) => Price.fromJson(x)),
          )
        : [],
    createdAt: json?["createdAt"] != null
        ? DateTime.tryParse(json!["createdAt"].toString())
        : null,
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "model_name": modelName,
    "prices": List<dynamic>.from(prices.map((x) => x.toJson())),
    "createdAt": createdAt?.toIso8601String(),
  };

  static String? _parseString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    return value.toString();
  }
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
    value: _parseInt(json?["value"]),
    headerId: _parseString(json?["header_id"]),
    headerKey: _parseString(json?["header_key"]),
    categoryKey: categoryKeyValues.map?[json?["category_key"]],
    priority: _parseInt(json?["priority"]),
    isMandatory: _parseBool(json?["is_mandatory"]),
    isDiscount: _parseBool(json?["is_discount"]),
    metadata: json?["metadata"] != null
        ? Metadata.fromJson(json?["metadata"])
        : null,
    branchId: branchIdValues.map?[_parseString(json?["branch_id"])],
    branchName: branchNameValues.map?[_parseString(json?["branch_name"])],
    branchCity: branchCityValues.map?[_parseString(json?["branch_city"])],
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

  static bool? _parseBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is int) return value != 0;
    if (value is double) return value != 0.0;
    if (value is String) {
      return value.toLowerCase() == 'true' || value == '1';
    }
    return false;
  }
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
    pageNo: _parseInt(json?["page_no"]),
    hsnCode: _parseInt(json?["hsn_code"]),
    gstRate: json?["gst_rate"],
  );

  Map<String?, dynamic>? toJson() => {
    "page_no": pageNo,
    "hsn_code": hsnCode,
    "gst_rate": gstRate,
  };

  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
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
