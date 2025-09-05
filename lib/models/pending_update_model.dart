import '../common/app_imports.dart';

PendingUpdateModel pendingUpdateModelFromJson(String str) =>
    PendingUpdateModel.fromJson(json.decode(str));

String pendingUpdateModelToJson(PendingUpdateModel data) =>
    json.encode(data.toJson());

class PendingUpdateModel {
  bool success;
  Data data;

  PendingUpdateModel({required this.success, required this.data});

  factory PendingUpdateModel.fromJson(Map<String, dynamic> json) =>
      PendingUpdateModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"success": success, "data": data.toJson()};
}

class Data {
  String id;
  String bookingNumber;
  String customerName;
  String model;
  String color;
  PendingUpdates pendingUpdates;
  String updateRequestStatus;
  String updateRequestNote;
  dynamic updateRequestedBy;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.bookingNumber,
    required this.customerName,
    required this.model,
    required this.color,
    required this.pendingUpdates,
    required this.updateRequestStatus,
    required this.updateRequestNote,
    required this.updateRequestedBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    bookingNumber: json["bookingNumber"],
    customerName: json["customerName"],
    model: json["model"],
    color: json["color"],
    pendingUpdates: PendingUpdates.fromJson(json["pendingUpdates"]),
    updateRequestStatus: json["updateRequestStatus"],
    updateRequestNote: json["updateRequestNote"],
    updateRequestedBy: json["updateRequestedBy"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "bookingNumber": bookingNumber,
    "customerName": customerName,
    "model": model,
    "color": color,
    "pendingUpdates": pendingUpdates.toJson(),
    "updateRequestStatus": updateRequestStatus,
    "updateRequestNote": updateRequestNote,
    "updateRequestedBy": updateRequestedBy,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class PendingUpdates {
  CustomerDetails customerDetails;
  String color;
  Payment payment;

  PendingUpdates({
    required this.customerDetails,
    required this.color,
    required this.payment,
  });

  factory PendingUpdates.fromJson(Map<String, dynamic> json) => PendingUpdates(
    customerDetails: CustomerDetails.fromJson(json["customerDetails"]),
    color: json["color"],
    payment: Payment.fromJson(json["payment"]),
  );

  Map<String, dynamic> toJson() => {
    "customerDetails": customerDetails.toJson(),
    "color": color,
    "payment": payment.toJson(),
  };
}

class CustomerDetails {
  String salutation;
  String name;
  String mobile1;
  String mobile2;
  String address;
  String pincode;

  CustomerDetails({
    required this.salutation,
    required this.name,
    required this.mobile1,
    required this.mobile2,
    required this.address,
    required this.pincode,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      CustomerDetails(
        salutation: json["salutation"],
        name: json["name"],
        mobile1: json["mobile1"],
        mobile2: json["mobile2"],
        address: json["address"],
        pincode: json["pincode"],
      );

  Map<String, dynamic> toJson() => {
    "salutation": salutation,
    "name": name,
    "mobile1": mobile1,
    "mobile2": mobile2,
    "address": address,
    "pincode": pincode,
  };
}

class Payment {
  String type;

  Payment({required this.type});

  factory Payment.fromJson(Map<String, dynamic> json) =>
      Payment(type: json["type"]);

  Map<String, dynamic> toJson() => {"type": type};
}
