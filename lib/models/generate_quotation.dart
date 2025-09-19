import 'package:gandhi_tvs/common/app_imports.dart';

GenerateQuotation generateQuotationFromJson(String str) =>
    GenerateQuotation.fromJson(json.decode(str));

String generateQuotationToJson(GenerateQuotation data) =>
    json.encode(data.toJson());

class GenerateQuotation {
  CustomerDetails customerDetails;
  List<SelectedModel> selectedModels;
  DateTime expectedDeliveryDate;
  bool financeNeeded;

  GenerateQuotation({
    required this.customerDetails,
    required this.selectedModels,
    required this.expectedDeliveryDate,
    required this.financeNeeded,
  });

  factory GenerateQuotation.fromJson(Map<String, dynamic> json) =>
      GenerateQuotation(
        customerDetails: CustomerDetails.fromJson(json["customerDetails"]),
        selectedModels: List<SelectedModel>.from(
          json["selectedModels"].map((x) => SelectedModel.fromJson(x)),
        ),
        expectedDeliveryDate: DateTime.parse(json["expected_delivery_date"]),
        financeNeeded: json["finance_needed"],
      );

  Map<String, dynamic> toJson() => {
    "customerDetails": customerDetails.toJson(),
    "selectedModels": List<dynamic>.from(selectedModels.map((x) => x.toJson())),
    "expected_delivery_date":
        "${expectedDeliveryDate.year.toString().padLeft(4, '0')}-${expectedDeliveryDate.month.toString().padLeft(2, '0')}-${expectedDeliveryDate.day.toString().padLeft(2, '0')}",
    "finance_needed": financeNeeded,
  };
}

class CustomerDetails {
  String name;
  String address;
  String taluka;
  String district;
  String mobile1;
  String mobile2;

  CustomerDetails({
    required this.name,
    required this.address,
    required this.taluka,
    required this.district,
    required this.mobile1,
    required this.mobile2,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      CustomerDetails(
        name: json["name"],
        address: json["address"],
        taluka: json["taluka"],
        district: json["district"],
        mobile1: json["mobile1"],
        mobile2: json["mobile2"],
      );

  Map<String, dynamic> toJson() => {
    "name": name,
    "address": address,
    "taluka": taluka,
    "district": district,
    "mobile1": mobile1,
    "mobile2": mobile2,
  };
}

class SelectedModel {
  String modelId;

  SelectedModel({required this.modelId});

  factory SelectedModel.fromJson(Map<String, dynamic> json) =>
      SelectedModel(modelId: json["model_id"]);

  Map<String, dynamic> toJson() => {"model_id": modelId};
}
