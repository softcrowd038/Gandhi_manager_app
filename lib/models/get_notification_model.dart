import 'package:gandhi_tvs/common/app_imports.dart';

GetNotificationMOdel getNotificationMOdelFromJson(String? str) =>
    GetNotificationMOdel.fromJson(json.decode(str ?? ""));

String? getNotificationMOdelToJson(GetNotificationMOdel data) =>
    json.encode(data.toJson());

class GetNotificationMOdel {
  bool? success;
  NotificationSummary notificationSummary;
  List<Datum> data;

  GetNotificationMOdel({
    required this.success,
    required this.notificationSummary,
    required this.data,
  });

  factory GetNotificationMOdel.fromJson(Map<String?, dynamic>? json) =>
      GetNotificationMOdel(
        success: json?["success"],
        notificationSummary: NotificationSummary.fromJson(
          json?["notificationSummary"],
        ),
        data: List<Datum>.from(
          (json?["data"] as List?)?.map((x) => Datum.fromJson(x)) ?? [],
        ),
      );

  Map<String?, dynamic>? toJson() => {
    "success": success,
    "notificationSummary": notificationSummary.toJson(),
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String? bookingId;
  String? bookingNumber;
  String? customerName;
  String? customerId;
  String? modelName;
  String? salesExecutiveName;
  String? bookingType;
  String? location;
  DateTime? createdAt;
  String? customMessage;
  int? totalAmount;
  int? discountedAmount;
  String? createdByName;

  Datum({
    required this.bookingId,
    required this.bookingNumber,
    required this.customerName,
    required this.customerId,
    required this.modelName,
    required this.salesExecutiveName,
    required this.bookingType,
    required this.location,
    required this.createdAt,
    required this.customMessage,
    required this.totalAmount,
    required this.discountedAmount,
    required this.createdByName,
  });

  factory Datum.fromJson(Map<String?, dynamic>? json) => Datum(
    bookingId: json?["bookingId"],
    bookingNumber: json?["bookingNumber"],
    customerName: json?["customerName"],
    customerId: json?["customerId"],
    modelName: json?["modelName"],
    salesExecutiveName: json?["salesExecutiveName"],
    bookingType: json?["bookingType"],
    location: json?["location"],
    createdAt: json?["createdAt"] != null
        ? DateTime.parse(json?["createdAt"])
        : null,
    customMessage: json?["customMessage"],
    totalAmount: _parseInt(json?["totalAmount"]),
    discountedAmount: _parseInt(json?["discountedAmount"]),
    createdByName: json?["createdByName"],
  );

  Map<String?, dynamic>? toJson() => {
    "bookingId": bookingId,
    "bookingNumber": bookingNumber,
    "customerName": customerName,
    "customerId": customerId,
    "modelName": modelName,
    "salesExecutiveName": salesExecutiveName,
    "bookingType": bookingType,
    "location": location,
    "createdAt": createdAt?.toIso8601String(),
    "customMessage": customMessage,
    "totalAmount": totalAmount,
    "discountedAmount": discountedAmount,
    "createdByName": createdByName,
  };

  // Helper function to handle both int and double values
  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}

class NotificationSummary {
  int? totalPending;
  int? currentPage;
  int? totalPages;
  String? message;

  NotificationSummary({
    required this.totalPending,
    required this.currentPage,
    required this.totalPages,
    required this.message,
  });

  factory NotificationSummary.fromJson(Map<String?, dynamic>? json) =>
      NotificationSummary(
        totalPending: _parseInt(json?["totalPending"]),
        currentPage: _parseInt(json?["currentPage"]),
        totalPages: _parseInt(json?["totalPages"]),
        message: json?["message"],
      );

  Map<String?, dynamic>? toJson() => {
    "totalPending": totalPending,
    "currentPage": currentPage,
    "totalPages": totalPages,
    "message": message,
  };

  // Helper function to handle both int and double values
  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }
}
