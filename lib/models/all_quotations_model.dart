// ignore_for_file: constant_identifier_names

import 'package:gandhi_tvs/common/app_imports.dart';

AllQuotationModel allQuotationModelFromJson(String? str) =>
    AllQuotationModel.fromJson(json.decode(str ?? ""));

String? allQuotationModelToJson(AllQuotationModel data) =>
    json.encode(data.toJson());

class AllQuotationModel {
  String? status;
  int? results;
  Data data;

  AllQuotationModel({
    required this.status,
    required this.results,
    required this.data,
  });

  factory AllQuotationModel.fromJson(Map<String?, dynamic>? json) =>
      AllQuotationModel(
        status: json?["status"],
        results: json?["results"],
        data: Data.fromJson(json?["data"]),
      );

  Map<String?, dynamic>? toJson() => {
    "status": status,
    "results": results,
    "data": data.toJson(),
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

  Map<String?, dynamic>? toJson() => {
    "quotations": List<dynamic>.from(quotations.map((x) => x.toJson())),
  };
}

class Quotation {
  String? id;
  String? quotationNumber;
  String? status;
  DateTime? createdAt;
  DateTime? expectedDeliveryDate;
  bool? financeNeeded;
  String? pdfUrl;
  Customer customer;
  Creator creator;
  List<Model> models;
  dynamic baseModel;

  Quotation({
    required this.id,
    required this.quotationNumber,
    required this.status,
    required this.createdAt,
    required this.expectedDeliveryDate,
    required this.financeNeeded,
    required this.pdfUrl,
    required this.customer,
    required this.creator,
    required this.models,
    required this.baseModel,
  });

  factory Quotation.fromJson(Map<String?, dynamic>? json) => Quotation(
    id: json?["_id"],
    quotationNumber: json?["quotation_number"],
    status: json?["status"],
    createdAt: DateTime.parse(json?["createdAt"]),
    expectedDeliveryDate: DateTime.parse(json?["expected_delivery_date"]),
    financeNeeded: json?["finance_needed"],
    pdfUrl: json?["pdfUrl"],
    customer: Customer.fromJson(json?["customer"]),
    creator: Creator.fromJson(json?["creator"]),
    models: List<Model>.from(json?["models"].map((x) => Model.fromJson(x))),
    baseModel: json?["base_model"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "quotation_number": quotationNumber,
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "expected_delivery_date": expectedDeliveryDate?.toIso8601String(),
    "finance_needed": financeNeeded,
    "pdfUrl": pdfUrl,
    "customer": customer.toJson(),
    "creator": creator.toJson(),
    "models": List<dynamic>.from(models.map((x) => x.toJson())),
    "base_model": baseModel,
  };
}

class Creator {
  String? id;
  String? email;
  String? mobile;
  Branch branch;

  Creator({
    required this.id,
    required this.email,
    required this.mobile,
    required this.branch,
  });

  factory Creator.fromJson(Map<String?, dynamic>? json) => Creator(
    id: json?["_id"],
    email: json?["email"],
    mobile: json?["mobile"],
    branch: Branch.fromJson(json?["branch"]),
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "email": email,
    "mobile": mobile,
    "branch": branch.toJson(),
  };
}

class Branch {
  Id id;
  String? name;
  String? city;

  Branch({required this.id, required this.name, required this.city});

  factory Branch.fromJson(Map<String?, dynamic>? json) => Branch(
    id: idValues.map[json?["_id"]]!,
    name: json?["name"],
    city: json?["city"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": idValues.reverse[id],
    "name": name,
    "city": city,
  };
}

enum Id { THE_68_C45_CFCB1965_F545_BCE5_F47 }

final idValues = EnumValues({
  "68c45cfcb1965f545bce5f47": Id.THE_68_C45_CFCB1965_F545_BCE5_F47,
});

class Customer {
  String? id;
  String? name;
  String? mobile1;
  String? address;
  String? taluka;
  String? district;

  Customer({
    required this.id,
    required this.name,
    required this.mobile1,
    required this.address,
    required this.taluka,
    required this.district,
  });

  factory Customer.fromJson(Map<String?, dynamic>? json) => Customer(
    id: json?["_id"],
    name: json?["name"],
    mobile1: json?["mobile1"],
    address: json?["address"],
    taluka: json?["taluka"],
    district: json?["district"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "name": name,
    "mobile1": mobile1,
    "address": address,
    "taluka": taluka,
    "district": district,
  };
}

class Model {
  String? id;
  String? modelName;
  List<Price> prices;
  int? exShowroomPrice;
  int? basePrice;
  String? series;

  Model({
    required this.id,
    required this.modelName,
    required this.prices,
    required this.exShowroomPrice,
    required this.basePrice,
    required this.series,
  });

  factory Model.fromJson(Map<String?, dynamic>? json) => Model(
    id: json?["_id"],
    modelName: json?["model_name"],
    prices: List<Price>.from(json?["prices"].map((x) => Price.fromJson(x))),
    exShowroomPrice: json?["ex_showroom_price"],
    basePrice: json?["base_price"],
    series: json?["series"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "model_name": modelName,
    "prices": List<dynamic>.from(prices.map((x) => x.toJson())),
    "ex_showroom_price": exShowroomPrice,
    "base_price": basePrice,
    "series": series,
  };
}

class Price {
  int? value;
  String? headerKey;
  CategoryKey categoryKey;
  int? priority;
  Metadata metadata;
  Id branchId;

  Price({
    required this.value,
    required this.headerKey,
    required this.categoryKey,
    required this.priority,
    required this.metadata,
    required this.branchId,
  });

  factory Price.fromJson(Map<String?, dynamic>? json) => Price(
    value: json?["value"],
    headerKey: json?["header_key"],
    categoryKey: categoryKeyValues.map[json?["category_key"]]!,
    priority: json?["priority"],
    metadata: Metadata.fromJson(json?["metadata"]),
    branchId: idValues.map[json?["branch_id"]]!,
  );

  Map<String?, dynamic>? toJson() => {
    "value": value,
    "header_key": headerKey,
    "category_key": categoryKeyValues.reverse[categoryKey],
    "priority": priority,
    "metadata": metadata.toJson(),
    "branch_id": idValues.reverse[branchId],
  };
}

enum CategoryKey { ACCESORIES, ADD_O_NSERVICES, DELETED, VEHICLE_PRICE }

final categoryKeyValues = EnumValues({
  "Accesories": CategoryKey.ACCESORIES,
  "AddONservices": CategoryKey.ADD_O_NSERVICES,
  "deleted": CategoryKey.DELETED,
  "vehicle_price": CategoryKey.VEHICLE_PRICE,
});

class Metadata {
  int? pageNo;
  String? hsnCode;
  String? gstRate;

  Metadata({this.pageNo, this.hsnCode, this.gstRate});

  factory Metadata.fromJson(Map<String?, dynamic>? json) => Metadata(
    pageNo: json?["page_no"],
    hsnCode: json?["hsn_code"],
    gstRate: json?["gst_rate"],
  );

  Map<String?, dynamic>? toJson() => {
    "page_no": pageNo,
    "hsn_code": hsnCode,
    "gst_rate": gstRate,
  };
}

class EnumValues<T> {
  Map<String?, T> map;
  late Map<T, String?> reverseMap;

  EnumValues(this.map);

  Map<T, String?> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
