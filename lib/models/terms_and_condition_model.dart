import 'package:gandhi_tvs/common/app_imports.dart';

TermsAndConditionModel termsAndConditionModelFromJson(String str) =>
    TermsAndConditionModel.fromJson(json.decode(str));

String termsAndConditionModelToJson(TermsAndConditionModel data) =>
    json.encode(data.toJson());

class TermsAndConditionModel {
  bool? success;
  int? count;
  List<Datum> data;

  TermsAndConditionModel({
    required this.success,
    required this.count,
    required this.data,
  });

  factory TermsAndConditionModel.fromJson(Map<String?, dynamic>? json) =>
      TermsAndConditionModel(
        success: json?["success"],
        count: json?["count"],
        data: List<Datum>.from(json?["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String?, dynamic>? toJson() => {
    "success": success,
    "count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String? id;
  String? title;
  String? content;
  bool? isActive;
  int? order;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Datum({
    required this.id,
    required this.title,
    required this.content,
    required this.isActive,
    required this.order,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Datum.fromJson(Map<String?, dynamic>? json) => Datum(
    id: json?["_id"],
    title: json?["title"],
    content: json?["content"],
    isActive: json?["isActive"],
    order: json?["order"],
    createdAt: DateTime.parse(json?["createdAt"]),
    updatedAt: DateTime.parse(json?["updatedAt"]),
    v: json?["__v"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "title": title,
    "content": content,
    "isActive": isActive,
    "order": order,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
