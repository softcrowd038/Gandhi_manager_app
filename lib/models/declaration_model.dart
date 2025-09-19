

import 'package:gandhi_tvs/common/app_imports.dart';

DeclarationModel declarationModelFromJson(String str) =>
    DeclarationModel.fromJson(json.decode(str));

String declarationModelToJson(DeclarationModel data) =>
    json.encode(data.toJson());

class DeclarationModel {
  String status;
  int results;
  Data data;

  DeclarationModel({
    required this.status,
    required this.results,
    required this.data,
  });

  factory DeclarationModel.fromJson(Map<String, dynamic> json) =>
      DeclarationModel(
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
  List<Declaration> declarations;

  Data({required this.declarations});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    declarations: List<Declaration>.from(
      json["declarations"].map((x) => Declaration.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "declarations": List<dynamic>.from(declarations.map((x) => x.toJson())),
  };
}

class Declaration {
  String id;
  String title;
  String content;
  String formType;
  int priority;
  String status;
  String createdBy;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  CreatedByDetails createdByDetails;
  String declarationId;

  Declaration({
    required this.id,
    required this.title,
    required this.content,
    required this.formType,
    required this.priority,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.createdByDetails,
    required this.declarationId,
  });

  factory Declaration.fromJson(Map<String, dynamic> json) => Declaration(
    id: json["_id"],
    title: json["title"],
    content: json["content"],
    formType: json["formType"],
    priority: json["priority"],
    status: json["status"],
    createdBy: json["createdBy"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    createdByDetails: CreatedByDetails.fromJson(json["createdByDetails"]),
    declarationId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "content": content,
    "formType": formType,
    "priority": priority,
    "status": status,
    "createdBy": createdBy,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "createdByDetails": createdByDetails.toJson(),
    "id": declarationId,
  };
}

class CreatedByDetails {
  String id;
  String name;
  String email;
  dynamic availableDeviationAmount;
  String createdByDetailsId;

  CreatedByDetails({
    required this.id,
    required this.name,
    required this.email,
    required this.availableDeviationAmount,
    required this.createdByDetailsId,
  });

  factory CreatedByDetails.fromJson(Map<String, dynamic> json) =>
      CreatedByDetails(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        availableDeviationAmount: json["availableDeviationAmount"],
        createdByDetailsId: json["id"],
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "availableDeviationAmount": availableDeviationAmount,
    "id": createdByDetailsId,
  };
}
