import 'package:gandhi_tvs/common/app_imports.dart';

AllQuotationModel allQuotationModelFromJson(String str) =>
    AllQuotationModel.fromJson(json.decode(str));

String allQuotationModelToJson(AllQuotationModel data) =>
    json.encode(data.toJson());

class AllQuotationModel {
  String status;
  int results;
  Data data;

  AllQuotationModel({
    required this.status,
    required this.results,
    required this.data,
  });

  factory AllQuotationModel.fromJson(Map<String, dynamic> json) =>
      AllQuotationModel(
        status: json["status"],
        results: json["results"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "results": results,
    "data": data.toJson(),
  };
}

class Data {
  List<Quotation> quotations;

  Data({required this.quotations});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    quotations: List<Quotation>.from(
      json["quotations"].map((x) => Quotation.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "quotations": List<dynamic>.from(quotations.map((x) => x.toJson())),
  };
}

class Quotation {
  String id;
  String quotationNumber;
  String status;
  DateTime createdAt;
  DateTime expectedDeliveryDate;
  bool financeNeeded;
  String pdfUrl;
  Customer customer;
  Creator creator;
  List<dynamic> models;
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

  factory Quotation.fromJson(Map<String, dynamic> json) => Quotation(
    id: json["_id"],
    quotationNumber: json["quotation_number"],
    status: json["status"],
    createdAt: DateTime.parse(json["createdAt"]),
    expectedDeliveryDate: DateTime.parse(json["expected_delivery_date"]),
    financeNeeded: json["finance_needed"],
    pdfUrl: json["pdfUrl"],
    customer: Customer.fromJson(json["customer"]),
    creator: Creator.fromJson(json["creator"]),
    models: List<dynamic>.from(json["models"].map((x) => x)),
    baseModel: json["base_model"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "quotation_number": quotationNumber,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "expected_delivery_date": expectedDeliveryDate.toIso8601String(),
    "finance_needed": financeNeeded,
    "pdfUrl": pdfUrl,
    "customer": customer.toJson(),
    "creator": creator.toJson(),
    "models": List<dynamic>.from(models.map((x) => x)),
    "base_model": baseModel,
  };
}

class Creator {
  String id;
  String email;
  String mobile;
  Branch branch;

  Creator({
    required this.id,
    required this.email,
    required this.mobile,
    required this.branch,
  });

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
    id: json["_id"],
    email: json["email"],
    mobile: json["mobile"],
    branch: Branch.fromJson(json["branch"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "mobile": mobile,
    "branch": branch.toJson(),
  };
}

class Branch {
  String id;
  String name;
  String city;

  Branch({required this.id, required this.name, required this.city});

  factory Branch.fromJson(Map<String, dynamic> json) =>
      Branch(id: json["_id"], name: json["name"], city: json["city"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "city": city};
}

class Customer {
  String id;
  String name;
  String mobile1;
  String address;
  String taluka;
  String district;

  Customer({
    required this.id,
    required this.name,
    required this.mobile1,
    required this.address,
    required this.taluka,
    required this.district,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["_id"],
    name: json["name"],
    mobile1: json["mobile1"],
    address: json["address"],
    taluka: json["taluka"],
    district: json["district"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "mobile1": mobile1,
    "address": address,
    "taluka": taluka,
    "district": district,
  };
}
