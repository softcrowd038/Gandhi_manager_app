import 'package:gandhi_tvs/common/app_imports.dart';

GetChassisNumberModel getChassisNumberModelFromJson(String str) =>
    GetChassisNumberModel.fromJson(json.decode(str));

String getChassisNumberModelToJson(GetChassisNumberModel data) =>
    json.encode(data.toJson());

class GetChassisNumberModel {
  String status;
  int results;
  Data data;

  GetChassisNumberModel({
    required this.status,
    required this.results,
    required this.data,
  });

  factory GetChassisNumberModel.fromJson(Map<String, dynamic> json) =>
      GetChassisNumberModel(
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
  String modelId;
  String modelName;
  String colorId;
  String colorName;
  List<String> chassisNumbers;

  Data({
    required this.modelId,
    required this.modelName,
    required this.colorId,
    required this.colorName,
    required this.chassisNumbers,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    modelId: json["modelId"],
    modelName: json["modelName"],
    colorId: json["colorId"],
    colorName: json["colorName"],
    chassisNumbers: List<String>.from(json["chassisNumbers"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "modelId": modelId,
    "modelName": modelName,
    "colorId": colorId,
    "colorName": colorName,
    "chassisNumbers": List<dynamic>.from(chassisNumbers.map((x) => x)),
  };
}
