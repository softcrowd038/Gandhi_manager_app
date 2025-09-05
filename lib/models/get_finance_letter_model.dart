import 'package:gandhi_tvs/common/app_imports.dart';

GetFinanceLetterModel getFinanceLetterModelFromJson(String? str) =>
    GetFinanceLetterModel.fromJson(json.decode(str ?? ""));

String? getFinanceLetterModelToJson(GetFinanceLetterModel data) =>
    json.encode(data.toJson());

class GetFinanceLetterModel {
  bool? success;
  Data data;

  GetFinanceLetterModel({required this.success, required this.data});

  factory GetFinanceLetterModel.fromJson(Map<String?, dynamic>? json) =>
      GetFinanceLetterModel(
        success: json?["success"],
        data: Data.fromJson(json?["data"]),
      );

  Map<String?, dynamic>? toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  String? bookingId;
  String? id;
  String? booking;
  String? customerName;
  String? financeLetter;
  String? status;
  DateTime createdAt;
  DateTime updatedAt;
  int? v;

  Data({
    required this.bookingId,
    required this.id,
    required this.booking,
    required this.customerName,
    required this.financeLetter,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String?, dynamic>? json) => Data(
    bookingId: json?["bookingId"],
    id: json?["_id"],
    booking: json?["booking"],
    customerName: json?["customerName"],
    financeLetter: json?["financeLetter"],
    status: json?["status"],
    createdAt: DateTime.parse(json?["createdAt"]),
    updatedAt: DateTime.parse(json?["updatedAt"]),
    v: json?["__v"],
  );

  Map<String?, dynamic>? toJson() => {
    "bookingId": bookingId,
    "_id": id,
    "booking": booking,
    "customerName": customerName,
    "financeLetter": financeLetter,
    "status": status,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
