// ignore_for_file: constant_identifier_names

import 'package:gandhi_tvs/common/app_imports.dart';

GetBookingsByIdModel getBookingsByIdModelFromJson(String str) =>
    GetBookingsByIdModel.fromJson(json.decode(str));

String getBookingsByIdModelToJson(GetBookingsByIdModel data) =>
    json.encode(data.toJson());

class GetBookingsByIdModel {
  bool? success;
  Data? data;

  GetBookingsByIdModel({this.success, this.data});

  factory GetBookingsByIdModel.fromJson(Map<String, dynamic> json) =>
      GetBookingsByIdModel(
        success: json["success"] as bool?,
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"success": success, "data": data?.toJson()};
}

extension NumParsing on num {
  int? tryToInt() => this is int ? this as int : toInt();
}

class Data {
  CustomerDetails? customerDetails;
  Model? model;
  String? bookingType;
  Branch? color;
  bool? chassisNumberChangeAllowed;
  String? customerType;
  bool? isCsd;
  String? gstin;
  String? rto;
  String? rtoStatus;
  bool? hpa;
  int? rtoAmount;
  int? hypothecationCharges;
  String? kycStatus;
  String? financeLetterStatus;
  bool? exchange;
  ExchangeDetails? exchangeDetails;
  Payment? payment;
  List<AccessoryElement> accessories;
  List<PriceComponent> priceComponents;
  List<Discount> discounts;
  int? accessoriesTotal;
  int? totalAmount;
  int? discountedAmount;
  int? receivedAmount;
  List<dynamic> receipts;
  List<dynamic> ledgerEntries;
  String? status;
  String? insuranceStatus;
  Branch? branch;
  Branch? createdBy;
  SalesExecutive? salesExecutive;
  String? formPath;
  bool? formGenerated;
  String? qrCode;
  dynamic pendingUpdates;
  String? updateRequestStatus;
  String? updateRequestNote;
  bool? updateRequestSubmitted;
  List<ChassisNumberHistory> chassisNumberHistory;
  int? balanceAmount;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? bookingNumber;
  DateTime? approvedAt;
  Branch? approvedBy;
  String? chassisNumber;
  dynamic vehicle;
  String? fullCustomerName;
  String? id;
  dynamic batteryNumber;
  dynamic keyNumber;
  dynamic motorNumber;
  dynamic chargerNumber;
  dynamic engineNumber;

  Data({
    this.customerDetails,
    this.model,
    this.bookingType,
    this.color,
    this.chassisNumberChangeAllowed,
    this.customerType,
    this.isCsd,
    this.gstin,
    this.rto,
    this.rtoStatus,
    this.rtoAmount,
    this.hpa,
    this.hypothecationCharges,
    this.kycStatus,
    this.financeLetterStatus,
    this.exchange,
    this.exchangeDetails,
    this.payment,
    this.accessories = const [],
    this.priceComponents = const [],
    this.discounts = const [],
    this.accessoriesTotal,
    this.totalAmount,
    this.discountedAmount,
    this.receivedAmount,
    this.receipts = const [],
    this.ledgerEntries = const [],
    this.status,
    this.insuranceStatus,
    this.branch,
    this.createdBy,
    this.salesExecutive,
    this.formPath,
    this.formGenerated,
    this.qrCode,
    this.pendingUpdates,
    this.updateRequestStatus,
    this.updateRequestNote,
    this.updateRequestSubmitted,
    this.chassisNumberHistory = const [],
    this.balanceAmount,
    this.createdAt,
    this.updatedAt,
    this.bookingNumber,
    this.approvedAt,
    this.approvedBy,
    this.chassisNumber,
    this.vehicle,
    this.fullCustomerName,
    this.id,
    this.batteryNumber,
    this.keyNumber,
    this.motorNumber,
    this.chargerNumber,
    this.engineNumber,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    customerDetails: json["customerDetails"] == null
        ? null
        : CustomerDetails.fromJson(json["customerDetails"]),
    model: json["model"] == null ? null : Model.fromJson(json["model"]),
    bookingType: json["bookingType"] as String?,
    color: json["color"] == null ? null : Branch.fromJson(json["color"]),
    chassisNumberChangeAllowed: json["chassisNumberChangeAllowed"] as bool?,
    customerType: json["customerType"] as String?,
    isCsd: json["isCSD"] as bool?,
    gstin: json["gstin"] as String?,
    rto: json["rto"] as String?,
    rtoStatus: json["rtoStatus"] as String?,
    rtoAmount: json["rtoAmount"],
    hpa: json["hpa"] as bool?,
    hypothecationCharges: (json["hypothecationCharges"] as num?)?.tryToInt(),
    kycStatus: json["kycStatus"] as String?,
    financeLetterStatus: json["financeLetterStatus"] as String?,
    exchange: json["exchange"] as bool?,
    exchangeDetails: json["exchangeDetails"] == null
        ? null
        : ExchangeDetails.fromJson(json["exchangeDetails"]),
    payment: json["payment"] == null ? null : Payment.fromJson(json["payment"]),
    accessories: json["accessories"] == null
        ? []
        : List<AccessoryElement>.from(
            json["accessories"].map((x) => AccessoryElement.fromJson(x)),
          ),
    priceComponents: json["priceComponents"] == null
        ? []
        : List<PriceComponent>.from(
            json["priceComponents"].map((x) => PriceComponent.fromJson(x)),
          ),
    discounts: json["discounts"] == null
        ? []
        : List<Discount>.from(
            json["discounts"].map((x) => Discount.fromJson(x)),
          ),
    accessoriesTotal: (json["accessoriesTotal"] as num?)?.tryToInt(),
    totalAmount: (json["totalAmount"] as num?)?.tryToInt(),
    discountedAmount: (json["discountedAmount"] as num?)?.tryToInt(),
    receivedAmount: (json["receivedAmount"] as num?)?.tryToInt(),
    receipts: List<dynamic>.from(json["receipts"] ?? []),
    ledgerEntries: List<dynamic>.from(json["ledgerEntries"] ?? []),
    status: json["status"] as String?,
    insuranceStatus: json["insuranceStatus"] as String?,
    branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
    createdBy: json["createdBy"] == null
        ? null
        : Branch.fromJson(json["createdBy"]),
    salesExecutive: json["salesExecutive"] == null
        ? null
        : SalesExecutive.fromJson(json["salesExecutive"]),
    formPath: json["formPath"] as String?,
    formGenerated: json["formGenerated"] as bool?,
    qrCode: json["qrCode"] as String?,
    pendingUpdates: json["pendingUpdates"],
    updateRequestStatus: json["updateRequestStatus"] as String?,
    updateRequestNote: json["updateRequestNote"] as String?,
    updateRequestSubmitted: json["updateRequestSubmitted"] as bool?,
    chassisNumberHistory: json["chassisNumberHistory"] == null
        ? []
        : List<ChassisNumberHistory>.from(
            json["chassisNumberHistory"].map(
              (x) => ChassisNumberHistory.fromJson(x),
            ),
          ),
    balanceAmount: (json["balanceAmount"] as num?)?.tryToInt(),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    bookingNumber: json["bookingNumber"] as String?,
    approvedAt: json["approvedAt"] == null
        ? null
        : DateTime.parse(json["approvedAt"]),
    approvedBy: json["approvedBy"] == null
        ? null
        : Branch.fromJson(json["approvedBy"]),
    chassisNumber: json["chassisNumber"] as String?,
    vehicle: json["vehicle"],
    fullCustomerName: json["fullCustomerName"] as String?,
    id: json["id"] as String?,
    batteryNumber: json["batteryNumber"],
    keyNumber: json["keyNumber"],
    motorNumber: json["motorNumber"],
    chargerNumber: json["chargerNumber"],
    engineNumber: json["engineNumber"],
  );

  Map<String, dynamic> toJson() => {
    "customerDetails": customerDetails?.toJson(),
    "model": model?.toJson(),
    "bookingType": bookingType,
    "color": color?.toJson(),
    "chassisNumberChangeAllowed": chassisNumberChangeAllowed,
    "customerType": customerType,
    "isCSD": isCsd,
    "gstin": gstin,
    "rto": rto,
    "rtoStatus": rtoStatus,
    "rtoAmount": rtoAmount,
    "hpa": hpa,
    "hypothecationCharges": hypothecationCharges,
    "kycStatus": kycStatus,
    "financeLetterStatus": financeLetterStatus,
    "exchange": exchange,
    "exchangeDetails": exchangeDetails?.toJson(),
    "payment": payment?.toJson(),
    "accessories": List<dynamic>.from(accessories.map((x) => x.toJson())),
    "priceComponents": List<dynamic>.from(
      priceComponents.map((x) => x.toJson()),
    ),
    "discounts": List<dynamic>.from(discounts.map((x) => x.toJson())),
    "accessoriesTotal": accessoriesTotal,
    "totalAmount": totalAmount,
    "discountedAmount": discountedAmount,
    "receivedAmount": receivedAmount,
    "receipts": List<dynamic>.from(receipts.map((x) => x)),
    "ledgerEntries": List<dynamic>.from(ledgerEntries.map((x) => x)),
    "status": status,
    "insuranceStatus": insuranceStatus,
    "branch": branch?.toJson(),
    "createdBy": createdBy?.toJson(),
    "salesExecutive": salesExecutive?.toJson(),
    "formPath": formPath,
    "formGenerated": formGenerated,
    "qrCode": qrCode,
    "pendingUpdates": pendingUpdates,
    "updateRequestStatus": updateRequestStatus,
    "updateRequestNote": updateRequestNote,
    "updateRequestSubmitted": updateRequestSubmitted,
    "chassisNumberHistory": List<dynamic>.from(
      chassisNumberHistory.map((x) => x.toJson()),
    ),
    "balanceAmount": balanceAmount,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "bookingNumber": bookingNumber,
    "approvedAt": approvedAt?.toIso8601String(),
    "approvedBy": approvedBy?.toJson(),
    "chassisNumber": chassisNumber,
    "vehicle": vehicle,
    "fullCustomerName": fullCustomerName,
    "id": id,
    "batteryNumber": batteryNumber,
    "keyNumber": keyNumber,
    "motorNumber": motorNumber,
    "chargerNumber": chargerNumber,
    "engineNumber": engineNumber,
  };
}

class ChassisNumberHistory {
  String? number;
  DateTime? changedAt;
  String? changedBy;
  String? reason;
  String? statusAtChange;
  String? id;

  ChassisNumberHistory({
    this.number,
    this.changedAt,
    this.changedBy,
    this.reason,
    this.statusAtChange,
    this.id,
  });

  factory ChassisNumberHistory.fromJson(Map<String, dynamic> json) =>
      ChassisNumberHistory(
        number: json["number"] as String?,
        changedAt: json["changedAt"] == null
            ? null
            : DateTime.parse(json["changedAt"]),
        changedBy: json["changedBy"] as String?,
        reason: json["reason"] as String?,
        statusAtChange: json["statusAtChange"] as String?,
        id: json["id"] as String?,
      );

  Map<String, dynamic> toJson() => {
    "number": number,
    "changedAt": changedAt?.toIso8601String(),
    "changedBy": changedBy,
    "reason": reason,
    "statusAtChange": statusAtChange,
    "id": id,
  };
}

class AccessoryElement {
  AccessoryAccessory? accessory;
  int? price;
  int? discount;
  bool? isAdjustment;

  AccessoryElement({
    this.accessory,
    this.price,
    this.discount,
    this.isAdjustment,
  });

  factory AccessoryElement.fromJson(Map<String, dynamic> json) =>
      AccessoryElement(
        accessory: json["accessory"] == null
            ? null
            : AccessoryAccessory.fromJson(json["accessory"]),
        price: (json["price"] as num?)?.tryToInt(),
        discount: (json["discount"] as num?)?.tryToInt(),
        isAdjustment: json["isAdjustment"] as bool?,
      );

  Map<String, dynamic> toJson() => {
    "accessory": accessory?.toJson(),
    "price": price,
    "discount": discount,
    "isAdjustment": isAdjustment,
  };
}

class AccessoryAccessory {
  String? id;
  String? name;
  String? category;
  String? accessoryId;

  AccessoryAccessory({this.id, this.name, this.category, this.accessoryId});

  factory AccessoryAccessory.fromJson(Map<String, dynamic> json) =>
      AccessoryAccessory(
        id: json["_id"] as String?,
        name: json["name"] as String?,
        category: json["category"] as String?,
        accessoryId: json["id"] as String?,
      );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "category": category,
    "id": accessoryId,
  };
}

class Branch {
  String? id;
  String? name;
  String? address;
  String? email;
  String? mobile;
  String? branchId;

  Branch({
    this.id,
    this.name,
    this.address,
    this.email,
    this.mobile,
    this.branchId,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: json["_id"] as String?,
    name: json["name"] as String?,
    address: json["address"] as String?,
    email: json["email"] as String?,
    mobile: json["mobile"] as String?,
    branchId: json["id"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "address": address,
    "email": email,
    "mobile": mobile,
    "id": branchId,
  };
}

class SalesExecutive {
  String? id;
  String? name;
  String? email;
  String? mobile;
  Branch? branch;

  SalesExecutive({this.id, this.name, this.email, this.mobile, this.branch});

  factory SalesExecutive.fromJson(Map<String, dynamic> json) => SalesExecutive(
    id: json["_id"] as String?,
    name: json["name"] as String?,
    email: json["email"] as String?,
    mobile: json["mobile"] as String?,
    branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "branch": branch?.toJson(),
  };
}

class CustomerDetails {
  String? salutation;
  String? name;
  String? panNo;
  String? dob;
  String? occupation;
  String? address;
  String? taluka;
  String? district;
  String? pincode;
  String? mobile1;
  String? mobile2;
  String? aadharNumber;
  String? nomineeName;
  String? nomineeRelation;
  int? nomineeAge;
  String? fullName;

  CustomerDetails({
    this.salutation,
    this.name,
    this.panNo,
    this.dob,
    this.occupation,
    this.address,
    this.taluka,
    this.district,
    this.pincode,
    this.mobile1,
    this.mobile2,
    this.aadharNumber,
    this.nomineeName,
    this.nomineeRelation,
    this.nomineeAge,
    this.fullName,
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      CustomerDetails(
        salutation: json["salutation"] as String?,
        name: json["name"] as String?,
        panNo: json["panNo"] as String?,
        dob: json["dob"] as String?,
        occupation: json["occupation"] as String?,
        address: json["address"] as String?,
        taluka: json["taluka"] as String?,
        district: json["district"] as String?,
        pincode: json["pincode"] as String?,
        mobile1: json["mobile1"] as String?,
        mobile2: json["mobile2"] as String?,
        aadharNumber: json["aadharNumber"] as String?,
        nomineeName: json["nomineeName"] as String?,
        nomineeRelation: json["nomineeRelation"] as String?,
        nomineeAge: json["nomineeAge"] as int?,
        fullName: json["fullName"] as String?,
      );

  Map<String, dynamic> toJson() => {
    "salutation": salutation,
    "name": name,
    "panNo": panNo,
    "dob": dob,
    "occupation": occupation,
    "address": address,
    "taluka": taluka,
    "district": district,
    "pincode": pincode,
    "mobile1": mobile1,
    "mobile2": mobile2,
    "aadharNumber": aadharNumber,
    "nomineeName": nomineeName,
    "nomineeRelation": nomineeRelation,
    "nomineeAge": nomineeAge,
    "fullName": fullName,
  };
}

class Discount {
  int? amount;
  String? type;
  String? approvalStatus;
  String? approvalNote;
  DateTime? appliedOn;
  String? approvedBy;

  Discount({
    this.amount,
    this.type,
    this.approvalStatus,
    this.approvalNote,
    this.appliedOn,
    this.approvedBy,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
    amount: (json["amount"] as num?)?.tryToInt(),
    type: json["type"] as String?,
    approvalStatus: json["approvalStatus"] as String?,
    approvalNote: json["approvalNote"] as String?,
    appliedOn: json["appliedOn"] == null
        ? null
        : DateTime.parse(json["appliedOn"]),
    approvedBy: json["approvedBy"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "type": type,
    "approvalStatus": approvalStatus,
    "approvalNote": approvalNote,
    "appliedOn": appliedOn?.toIso8601String(),
    "approvedBy": approvedBy,
  };
}

class Model {
  String? modelName;
  String? type;
  String? displayName;
  String? id;
  String? name;

  Model({this.modelName, this.type, this.displayName, this.id, this.name});

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    modelName: json["model_name"] as String?,
    type: json["type"] as String?,
    displayName: json["display_name"] as String?,
    id: json["id"] as String?,
    name: json["name"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "model_name": modelName,
    "type": type,
    "display_name": displayName,
    "id": id,
    "name": name,
  };
}

class Payment {
  String? type;
  Financer? financer;
  String? scheme;
  String? emiPlan;
  bool? gcApplicable;
  int? gcAmount;

  Payment({
    this.type,
    this.financer,
    this.scheme,
    this.emiPlan,
    this.gcApplicable,
    this.gcAmount,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    type: json["type"] as String?,
    financer: json["financer"] == null
        ? null
        : Financer.fromJson(json["financer"]),
    scheme: json["scheme"] as String?,
    emiPlan: json["emiPlan"] as String?,
    gcApplicable: json["gcApplicable"] as bool?,
    gcAmount: (json["gcAmount"] as num?)?.tryToInt(),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "financer": financer?.toJson(),
    "scheme": scheme,
    "emiPlan": emiPlan,
    "gcApplicable": gcApplicable,
    "gcAmount": gcAmount,
  };
}

class Financer {
  String? id;
  String? name;
  String? financerId;

  Financer({this.id, this.name, this.financerId});

  factory Financer.fromJson(Map<String, dynamic> json) => Financer(
    id: json["_id"] as String?,
    name: json["name"] as String?,
    financerId: json["id"] as String?,
  );

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "id": financerId};
}

class PriceComponent {
  Header? header;
  int? originalValue;
  int? discountedValue;
  bool? isDiscountable;
  bool? isMandatory;

  PriceComponent({
    this.header,
    this.originalValue,
    this.discountedValue,
    this.isDiscountable,
    this.isMandatory,
  });

  factory PriceComponent.fromJson(Map<String, dynamic> json) => PriceComponent(
    header: json["header"] == null ? null : Header.fromJson(json["header"]),
    originalValue: (json["originalValue"] as num?)?.tryToInt(),
    discountedValue: (json["discountedValue"] as num?)?.tryToInt(),
    isDiscountable: json["isDiscountable"] as bool?,
    isMandatory: json["isMandatory"] as bool?,
  );

  Map<String, dynamic> toJson() => {
    "header": header?.toJson(),
    "originalValue": originalValue,
    "discountedValue": discountedValue,
    "isDiscountable": isDiscountable,
    "isMandatory": isMandatory,
  };
}

class ExchangeDetails {
  Broker? broker;
  int? price;
  String? vehicleNumber;
  String? chassisNumber;
  bool? otpVerified;
  String? status;

  ExchangeDetails({
    this.broker,
    this.price,
    this.vehicleNumber,
    this.chassisNumber,
    this.otpVerified,
    this.status,
  });

  factory ExchangeDetails.fromJson(Map<String, dynamic> json) =>
      ExchangeDetails(
        broker: json["broker"] == null ? null : Broker.fromJson(json["broker"]),
        price: (json["price"] as num?)?.tryToInt(),
        vehicleNumber: json["vehicleNumber"] as String?,
        chassisNumber: json["chassisNumber"] as String?,
        otpVerified: json["otpVerified"] as bool?,
        status: json["status"] as String?,
      );

  Map<String, dynamic> toJson() => {
    "broker": broker?.toJson(),
    "price": price,
    "vehicleNumber": vehicleNumber,
    "chassisNumber": chassisNumber,
    "otpVerified": otpVerified,
    "status": status,
  };
}

class Broker {
  String? id;
  String? name;
  String? brokerId;

  Broker({this.id, this.name, this.brokerId});

  factory Broker.fromJson(Map<String, dynamic> json) => Broker(
    id: json["_id"] as String?,
    name: json["name"] as String?,
    brokerId: json["id"] as String?,
  );

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "id": brokerId};
}

class Header {
  String? id;
  String? headerKey;
  String? headerId;

  Header({this.id, this.headerKey, this.headerId});

  factory Header.fromJson(Map<String, dynamic> json) => Header(
    id: json["_id"] as String?,
    headerKey: json["header_key"] as String?,
    headerId: json["id"] as String?,
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "header_key": headerKey,
    "id": headerId,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
