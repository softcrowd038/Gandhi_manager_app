// ignore_for_file: constant_identifier_names

import 'package:gandhi_tvs/common/app_imports.dart';

AllBookingModel inwardModelDetailsFromJson(String str) =>
    AllBookingModel.fromJson(json.decode(str));

String inwardModelDetailsToJson(AllBookingModel data) =>
    json.encode(data.toJson());

class AllBookingModel {
  bool? success;
  Data? data;

  AllBookingModel({this.success, this.data});

  factory AllBookingModel.fromJson(Map<String, dynamic> json) =>
      AllBookingModel(
        success: json["success"] as bool?,
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"success": success, "data": data?.toJson()};
}

class Data {
  List<Booking>? bookings;
  int? total;
  int? pages;
  int? currentPage;

  Data({this.bookings, this.total, this.pages, this.currentPage});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    bookings: json["bookings"] == null
        ? []
        : List<Booking>.from(json["bookings"].map((x) => Booking.fromJson(x))),
    total: json["total"] as int?,
    pages: json["pages"] as int?,
    currentPage: json["currentPage"] as int?,
  );

  Map<String, dynamic> toJson() => {
    "bookings": bookings == null
        ? []
        : List<dynamic>.from(bookings!.map((x) => x.toJson())),
    "total": total,
    "pages": pages,
    "currentPage": currentPage,
  };
}

class Booking {
  String? id;
  Model? model;
  Color? color;
  CustomerType? customerType;
  String? gstin;
  Rto? rto;
  int? rtoAmount;
  bool? hpa;
  int? hypothecationCharges;
  CustomerDetails? customerDetails;
  bool? exchange;
  ExchangeDetails? exchangeDetails;
  Payment? payment;
  List<AccessoryElement>? accessories;
  List<PriceComponent>? priceComponents;
  List<Discount>? discounts;
  int? accessoriesTotal;
  int? totalAmount;
  int? discountedAmount;
  Status? status;
  Branch? branch;
  CreatedBy? createdBy;
  SalesExecutive? salesExecutive;
  String? formPath;
  bool? formGenerated;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? bookingNumber;
  int? v;
  String? bookingId;
  DocumentStatus? documentStatus;
  ApprovedBy? approvedBy;

  Booking({
    this.id,
    this.model,
    this.color,
    this.customerType,
    this.gstin,
    this.rto,
    this.rtoAmount,
    this.hpa,
    this.hypothecationCharges,
    this.customerDetails,
    this.exchange,
    this.exchangeDetails,
    this.payment,
    this.accessories,
    this.priceComponents,
    this.discounts,
    this.accessoriesTotal,
    this.totalAmount,
    this.discountedAmount,
    this.status,
    this.branch,
    this.createdBy,
    this.salesExecutive,
    this.formPath,
    this.formGenerated,
    this.createdAt,
    this.updatedAt,
    this.bookingNumber,
    this.v,
    this.bookingId,
    this.documentStatus,
    this.approvedBy,
  });

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json["_id"] as String?,
    model: json["model"] == null ? null : Model.fromJson(json["model"]),
    color: json["color"] == null ? null : Color.fromJson(json["color"]),
    customerType: json["customerType"] == null
        ? null
        : customerTypeValues.map[json["customerType"]],
    gstin: json["gstin"] as String?,
    rto: json["rto"] == null ? null : rtoValues.map[json["rto"]],
    rtoAmount: json["rtoAmount"] as int?,
    hpa: json["hpa"] as bool?,
    hypothecationCharges: json["hypothecationCharges"] as int?,
    customerDetails: json["customerDetails"] == null
        ? null
        : CustomerDetails.fromJson(json["customerDetails"]),
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
    accessoriesTotal: json["accessoriesTotal"] as int?,
    totalAmount: json["totalAmount"] as int?,
    discountedAmount: json["discountedAmount"] as int?,
    status: json["status"] == null ? null : statusValues.map[json["status"]],
    branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
    createdBy: json["createdBy"] == null
        ? null
        : CreatedBy.fromJson(json["createdBy"]),
    salesExecutive: json["salesExecutive"] == null
        ? null
        : SalesExecutive.fromJson(json["salesExecutive"]),
    formPath: json["formPath"] as String?,
    formGenerated: json["formGenerated"] as bool?,
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    bookingNumber: json["bookingNumber"] as String?,
    v: json["__v"] as int?,
    bookingId: json["id"] as String?,
    approvedBy: json["approvedBy"] == null
        ? null
        : approvedByValues.map[json["approvedBy"]],
    documentStatus: json["documentStatus"] == null
        ? null
        : DocumentStatus.fromJson(json["documentStatus"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "model": model?.toJson(),
    "color": color?.toJson(),
    "customerType": customerTypeValues.reverse[customerType],
    "gstin": gstin,
    "rto": rtoValues.reverse[rto],
    "rtoAmount": rtoAmount,
    "hpa": hpa,
    "hypothecationCharges": hypothecationCharges,
    "customerDetails": customerDetails?.toJson(),
    "exchange": exchange,
    "exchangeDetails": exchangeDetails?.toJson(),
    "payment": payment?.toJson(),
    "accessories": accessories == null
        ? []
        : List<dynamic>.from(accessories!.map((x) => x.toJson())),
    "priceComponents": priceComponents == null
        ? []
        : List<dynamic>.from(priceComponents!.map((x) => x.toJson())),
    "discounts": discounts == null
        ? []
        : List<dynamic>.from(discounts!.map((x) => x.toJson())),
    "accessoriesTotal": accessoriesTotal,
    "totalAmount": totalAmount,
    "discountedAmount": discountedAmount,
    "status": statusValues.reverse[status],
    "branch": branch?.toJson(),
    "createdBy": createdBy?.toJson(),
    "salesExecutive": salesExecutive?.toJson(),
    "formPath": formPath,
    "formGenerated": formGenerated,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "bookingNumber": bookingNumber,
    "__v": v,
    "id": bookingId,
    "approvedBy": approvedByValues.reverse[approvedBy],
    "documentStatus": documentStatus?.toJson(),
  };
}

class AccessoryElement {
  AccessoryEnum? accessory;
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
            : accessoryEnumValues.map[json["accessory"]],
        price: json["price"] as int?,
        discount: json["discount"] as int?,
        isAdjustment: json["isAdjustment"] as bool?,
      );

  Map<String, dynamic> toJson() => {
    "accessory": accessoryEnumValues.reverse[accessory],
    "price": price,
    "discount": discount,
    "isAdjustment": isAdjustment,
  };
}

enum AccessoryEnum {
  THE_685_E6494_D4_DFAA93_EAEC1_C5_C,
  THE_6864_D164_DA62_EFB358736_DE8,
  THE_686526_B3_A892_BD62_D685_BBAD,
}

final accessoryEnumValues = EnumValues({
  "685e6494d4dfaa93eaec1c5c": AccessoryEnum.THE_685_E6494_D4_DFAA93_EAEC1_C5_C,
  "6864d164da62efb358736de8": AccessoryEnum.THE_6864_D164_DA62_EFB358736_DE8,
  "686526b3a892bd62d685bbad": AccessoryEnum.THE_686526_B3_A892_BD62_D685_BBAD,
});

enum ApprovedBy {
  THE_68554_A1_F12_D0_C8279_C3867_FB,
  THE_68676_E839_EBD178_E2_C1_E6_F2_F,
}

final approvedByValues = EnumValues({
  "68554a1f12d0c8279c3867fb": ApprovedBy.THE_68554_A1_F12_D0_C8279_C3867_FB,
  "68676e839ebd178e2c1e6f2f": ApprovedBy.THE_68676_E839_EBD178_E2_C1_E6_F2_F,
});

class Branch {
  BranchIdEnum? id;
  BranchName? name;
  Address? address;
  Address? city;
  Address? state;
  String? pincode;
  String? phone;
  BranchEmail? email;
  GstNumber? gstNumber;
  bool? isActive;
  String? logo1;
  String? logo2;
  ApprovedBy? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Branch({
    this.id,
    this.name,
    this.address,
    this.city,
    this.state,
    this.pincode,
    this.phone,
    this.email,
    this.gstNumber,
    this.isActive,
    this.logo1,
    this.logo2,
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    id: branchIdEnumValues.map[json["_id"]],
    name: branchNameValues.map[json["name"]],
    address: addressValues.map[json["address"]],
    city: addressValues.map[json["city"]],
    state: addressValues.map[json["state"]],
    pincode: json["pincode"] as String?,
    phone: json["phone"] as String?,
    email: branchEmailValues.map[json["email"]],
    gstNumber: gstNumberValues.map[json["gst_number"]],
    isActive: json["is_active"] as bool?,
    logo1: json["logo1"] as String?,
    logo2: json["logo2"] as String?,
    createdBy: approvedByValues.map[json["createdBy"]],
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null
        ? null
        : DateTime.parse(json["updatedAt"]),
    v: json["__v"] as int?,
  );

  Map<String, dynamic> toJson() => {
    "_id": branchIdEnumValues.reverse[id],
    "name": branchNameValues.reverse[name],
    "address": addressValues.reverse[address],
    "city": addressValues.reverse[city],
    "state": addressValues.reverse[state],
    "pincode": pincode,
    "phone": phone,
    "email": branchEmailValues.reverse[email],
    "gst_number": gstNumberValues.reverse[gstNumber],
    "is_active": isActive,
    "logo1": logo1,
    "logo2": logo2,
    "createdBy": approvedByValues.reverse[createdBy],
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

enum Address { PUNE }

final addressValues = EnumValues({"Pune": Address.PUNE});

enum BranchEmail { EMAIL12_GMAIL_COM }

final branchEmailValues = EnumValues({
  "email12@gmail.com": BranchEmail.EMAIL12_GMAIL_COM,
});

enum GstNumber { THE_27_AAAAP0267_H2_ZN }

final gstNumberValues = EnumValues({
  "27AAAAP0267H2ZN": GstNumber.THE_27_AAAAP0267_H2_ZN,
});

enum BranchIdEnum { THE_685641_B4_A584_A450570_F20_AE }

final branchIdEnumValues = EnumValues({
  "685641b4a584a450570f20ae": BranchIdEnum.THE_685641_B4_A584_A450570_F20_AE,
});

enum BranchName { CIDCO_NASHIK }

final branchNameValues = EnumValues({"Cidco Nashik": BranchName.CIDCO_NASHIK});

class Color {
  IdElement? id;
  ColorName? name;

  Color({this.id, this.name});

  factory Color.fromJson(Map<String, dynamic> json) => Color(
    id: idElementValues.map[json["_id"]],
    name: colorNameValues.map[json["name"]],
  );

  Map<String, dynamic> toJson() => {
    "_id": idElementValues.reverse[id],
    "name": colorNameValues.reverse[name],
  };
}

enum IdElement {
  THE_685_A2_C6711_AA5936_A398061_E,
  THE_68676_BD6_E8_A5_B032_D8_BC49_EC,
}

final idElementValues = EnumValues({
  "685a2c6711aa5936a398061e": IdElement.THE_685_A2_C6711_AA5936_A398061_E,
  "68676bd6e8a5b032d8bc49ec": IdElement.THE_68676_BD6_E8_A5_B032_D8_BC49_EC,
});

enum ColorName { MIDNIGHT_BLACK_UPDATED }

final colorNameValues = EnumValues({
  "Midnight Black Updated": ColorName.MIDNIGHT_BLACK_UPDATED,
});

class CreatedBy {
  ApprovedBy? id;
  CreatedByName? name;
  CreatedByEmail? email;

  CreatedBy({this.id, this.name, this.email});

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
    id: approvedByValues.map[json["_id"]],
    name: createdByNameValues.map[json["name"]],
    email: createdByEmailValues.map[json["email"]],
  );

  Map<String, dynamic> toJson() => {
    "_id": approvedByValues.reverse[id],
    "name": createdByNameValues.reverse[name],
    "email": createdByEmailValues.reverse[email],
  };
}

enum CreatedByEmail { JOHN_EXAMPLE_COM, SALES_XECUTI8_VE7898_EXAMPLE_COM }

final createdByEmailValues = EnumValues({
  "john@example.com": CreatedByEmail.JOHN_EXAMPLE_COM,
  "sales.xecuti8ve7898@example.com":
      CreatedByEmail.SALES_XECUTI8_VE7898_EXAMPLE_COM,
});

enum CreatedByName { JOHN_DOE, SALES_EXECUTIVE }

final createdByNameValues = EnumValues({
  "John Doe": CreatedByName.JOHN_DOE,
  "Sales Executive": CreatedByName.SALES_EXECUTIVE,
});

class CustomerDetails {
  String? salutation;
  String? name;
  PanNo? panNo;
  DateTime? dob;
  String? occupation;
  String? address;
  String? taluka;
  String? district;
  String? pincode;
  String? mobile1;
  Mobile2? mobile2;
  String? aadharNumber;
  String? nomineeName;
  String? nomineeRelation;
  int? nomineeAge;

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
  });

  factory CustomerDetails.fromJson(Map<String, dynamic> json) =>
      CustomerDetails(
        salutation: json["salutation"] as String?,
        name: json["name"] as String?,
        panNo: panNoValues.map[json["panNo"]],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        occupation: json["occupation"] as String?,
        address: json["address"] as String?,
        taluka: json["taluka"] as String?,
        district: json["district"] as String?,
        pincode: json["pincode"] as String?,
        mobile1: json["mobile1"] as String?,
        mobile2: mobile2Values.map[json["mobile2"]],
        aadharNumber: json["aadharNumber"] as String?,
        nomineeName: json["nomineeName"] as String?,
        nomineeRelation: json["nomineeRelation"] as String?,
        nomineeAge: json["nomineeAge"] as int?,
      );

  Map<String, dynamic> toJson() => {
    "salutation": salutation,
    "name": name,
    "panNo": panNoValues.reverse[panNo],
    "dob": dob?.toIso8601String(),
    "occupation": occupation,
    "address": address,
    "taluka": taluka,
    "district": district,
    "pincode": pincode,
    "mobile1": mobile1,
    "mobile2": mobile2Values.reverse[mobile2],
    "aadharNumber": aadharNumber,
    "nomineeName": nomineeName,
    "nomineeRelation": nomineeRelation,
    "nomineeAge": nomineeAge,
  };
}

enum Mobile2 { EMPTY, THE_8080762003, THE_9876543211 }

final mobile2Values = EnumValues({
  "": Mobile2.EMPTY,
  "8080762003": Mobile2.THE_8080762003,
  "9876543211": Mobile2.THE_9876543211,
});

enum PanNo { AAACH2702_H, ABCDE1234_F, LXQBP6885_I }

final panNoValues = EnumValues({
  "AAACH2702H": PanNo.AAACH2702_H,
  "ABCDE1234F": PanNo.ABCDE1234_F,
  "LXQBP6885I": PanNo.LXQBP6885_I,
});

enum CustomerType { B2_B, B2_C }

final customerTypeValues = EnumValues({
  "B2B": CustomerType.B2_B,
  "B2C": CustomerType.B2_C,
});

class Discount {
  int? amount;
  DiscountType? type;
  ApprovalStatus? approvalStatus;
  DateTime? appliedOn;
  String? approvalNote;
  ApprovedBy? approvedBy;

  Discount({
    this.amount,
    this.type,
    this.approvalStatus,
    this.appliedOn,
    this.approvalNote,
    this.approvedBy,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
    amount: json["amount"] as int?,
    type: discountTypeValues.map[json["type"]],
    approvalStatus: approvalStatusValues.map[json["approvalStatus"]],
    appliedOn: json["appliedOn"] == null
        ? null
        : DateTime.parse(json["appliedOn"]),
    approvalNote: json["approvalNote"] as String?,
    approvedBy: approvedByValues.map[json["approvedBy"]],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "type": discountTypeValues.reverse[type],
    "approvalStatus": approvalStatusValues.reverse[approvalStatus],
    "appliedOn": appliedOn?.toIso8601String(),
    "approvalNote": approvalNote,
    "approvedBy": approvedByValues.reverse[approvedBy],
  };
}

enum ApprovalStatus { APPROVED, PENDING }

final approvalStatusValues = EnumValues({
  "APPROVED": ApprovalStatus.APPROVED,
  "PENDING": ApprovalStatus.PENDING,
});

enum DiscountType { FIXED }

final discountTypeValues = EnumValues({"FIXED": DiscountType.FIXED});

class ExchangeDetails {
  Broker? broker;
  int? price;
  String? vehicleNumber;
  String? chassisNumber;

  ExchangeDetails({
    this.broker,
    this.price,
    this.vehicleNumber,
    this.chassisNumber,
  });

  factory ExchangeDetails.fromJson(Map<String, dynamic> json) =>
      ExchangeDetails(
        broker: json["broker"] == null ? null : Broker.fromJson(json["broker"]),
        price: json["price"] as int?,
        vehicleNumber: json["vehicleNumber"] as String?,
        chassisNumber: json["chassisNumber"] as String?,
      );

  Map<String, dynamic> toJson() => {
    "broker": broker?.toJson(),
    "price": price,
    "vehicleNumber": vehicleNumber,
    "chassisNumber": chassisNumber,
  };
}

class Broker {
  String? id;
  String? name;
  String? mobile;

  Broker({this.id, this.name, this.mobile});

  factory Broker.fromJson(Map<String, dynamic> json) => Broker(
    id: json["_id"] as String?,
    name: json["name"] as String?,
    mobile: json["mobile"] as String?,
  );

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "mobile": mobile};
}

class Model {
  PurpleId? id;
  ModelName? modelName;
  ModelType? type;
  ModelStatus? status;
  List<Price>? prices;
  List<IdElement>? colors;
  DateTime? createdAt;

  Model({
    this.id,
    this.modelName,
    this.type,
    this.status,
    this.prices,
    this.colors,
    this.createdAt,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    id: purpleIdValues.map[json["_id"]],
    modelName: modelNameValues.map[json["model_name"]],
    type: modelTypeValues.map[json["type"]],
    status: modelStatusValues.map[json["status"]],
    prices: json["prices"] == null
        ? []
        : List<Price>.from(json["prices"].map((x) => Price.fromJson(x))),
    colors: json["colors"] == null
        ? []
        : List<IdElement>.from(
            json["colors"]
                .map((x) => idElementValues.map[x])
                .where((e) => e != null)
                .cast<IdElement>(),
          ),
    createdAt: json["createdAt"] == null
        ? null
        : DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": purpleIdValues.reverse[id],
    "model_name": modelNameValues.reverse[modelName],
    "type": modelTypeValues.reverse[type],
    "status": modelStatusValues.reverse[status],
    "prices": prices == null
        ? []
        : List<dynamic>.from(prices!.map((x) => x.toJson())),
    "colors": colors == null
        ? []
        : List<dynamic>.from(colors!.map((x) => idElementValues.reverse[x])),
    "createdAt": createdAt?.toIso8601String(),
  };
}

enum PurpleId {
  THE_685_D1_C1_D7_C59_AD32056_AB6_E4,
  THE_685_D1_C1_D7_C59_AD32056_AB6_E7,
}

final purpleIdValues = EnumValues({
  "685d1c1d7c59ad32056ab6e4": PurpleId.THE_685_D1_C1_D7_C59_AD32056_AB6_E4,
  "685d1c1d7c59ad32056ab6e7": PurpleId.THE_685_D1_C1_D7_C59_AD32056_AB6_E7,
});

enum ModelName { XL_100_COMFORT_KICKSTART_OBD_IIB, XL_100_HD_KICKSTART_OBD_IIB }

final modelNameValues = EnumValues({
  "XL 100 COMFORT KICKSTART OBD IIB":
      ModelName.XL_100_COMFORT_KICKSTART_OBD_IIB,
  "XL 100 HD KICKSTART OBD IIB": ModelName.XL_100_HD_KICKSTART_OBD_IIB,
});

class Price {
  int? value;
  String? headerId;
  BranchIdEnum? branchId;

  Price({this.value, this.headerId, this.branchId});

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    value: json["value"] as int?,
    headerId: json["header_id"] as String?,
    branchId: branchIdEnumValues.map[json["branch_id"]],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "header_id": headerId,
    "branch_id": branchIdEnumValues.reverse[branchId],
  };
}

enum ModelStatus { ACTIVE }

final modelStatusValues = EnumValues({"active": ModelStatus.ACTIVE});

enum ModelType { ICE }

final modelTypeValues = EnumValues({"ICE": ModelType.ICE});

class Payment {
  PaymentType? type;
  Financer? financer;
  String? scheme;
  String? emiPlan;
  bool? gcApplicable;
  double? gcAmount;

  Payment({
    this.type,
    this.financer,
    this.scheme,
    this.emiPlan,
    this.gcApplicable,
    this.gcAmount,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    type: paymentTypeValues.map[json["type"]],
    financer: json["financer"] == null
        ? null
        : Financer.fromJson(json["financer"]),
    scheme: json["scheme"] as String?,
    emiPlan: json["emiPlan"] as String?,
    gcApplicable: json["gcApplicable"] as bool?,
    gcAmount: json["gcAmount"] is int
        ? (json["gcAmount"] as int).toDouble()
        : json["gcAmount"] is double
        ? json["gcAmount"]
        : double.tryParse(json["gcAmount"]?.toString() ?? '0.0'),
  );

  Map<String, dynamic> toJson() => {
    "type": paymentTypeValues.reverse[type],
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

  Financer({this.id, this.name});

  factory Financer.fromJson(Map<String, dynamic> json) =>
      Financer(id: json["_id"] as String?, name: json["name"] as String?);

  Map<String, dynamic> toJson() => {"_id": id, "name": name};
}

enum PaymentType { CASH, FINANCE }

final paymentTypeValues = EnumValues({
  "CASH": PaymentType.CASH,
  "FINANCE": PaymentType.FINANCE,
});

class PriceComponent {
  String? header;
  int? originalValue;
  double? discountedValue;
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
    header: json["header"] as String?,
    originalValue: json["originalValue"] as int?,
    discountedValue: json["discountedValue"] is int
        ? (json["discountedValue"] as int).toDouble()
        : json["discountedValue"] is double
        ? json["discountedValue"]
        : double.tryParse(json["discountedValue"]?.toString() ?? '0.0'),
    isDiscountable: json["isDiscountable"] as bool?,
    isMandatory: json["isMandatory"] as bool?,
  );

  Map<String, dynamic> toJson() => {
    "header": header,
    "originalValue": originalValue,
    "discountedValue": discountedValue,
    "isDiscountable": isDiscountable,
    "isMandatory": isMandatory,
  };
}

enum Rto { BH, MH }

final rtoValues = EnumValues({"BH": Rto.BH, "MH": Rto.MH});

class SalesExecutive {
  SalesExecutiveId? id;
  CreatedByName? name;
  SalesExecutiveEmail? email;

  SalesExecutive({this.id, this.name, this.email});

  factory SalesExecutive.fromJson(Map<String, dynamic> json) => SalesExecutive(
    id: salesExecutiveIdValues.map[json["_id"]],
    name: createdByNameValues.map[json["name"]],
    email: salesExecutiveEmailValues.map[json["email"]],
  );

  Map<String, dynamic> toJson() => {
    "_id": salesExecutiveIdValues.reverse[id],
    "name": createdByNameValues.reverse[name],
    "email": salesExecutiveEmailValues.reverse[email],
  };
}

enum SalesExecutiveEmail {
  SALES_EXECUTIVE78_EXAMPLE_COM,
  SALES_EXECUTIVE_EXAMPLE_COM,
  SALES_XECUTI8_VE7898_EXAMPLE_COM,
}

final salesExecutiveEmailValues = EnumValues({
  "sales.executive78@example.com":
      SalesExecutiveEmail.SALES_EXECUTIVE78_EXAMPLE_COM,
  "sales.executive@example.com":
      SalesExecutiveEmail.SALES_EXECUTIVE_EXAMPLE_COM,
  "sales.xecuti8ve7898@example.com":
      SalesExecutiveEmail.SALES_XECUTI8_VE7898_EXAMPLE_COM,
});

enum SalesExecutiveId {
  THE_68676_C678101_F32_D22_E4_EF72,
  THE_68676_CCC4_B58_F3_A06372724_E,
  THE_68676_E839_EBD178_E2_C1_E6_F2_F,
}

final salesExecutiveIdValues = EnumValues({
  "68676c678101f32d22e4ef72":
      SalesExecutiveId.THE_68676_C678101_F32_D22_E4_EF72,
  "68676ccc4b58f3a06372724e":
      SalesExecutiveId.THE_68676_CCC4_B58_F3_A06372724_E,
  "68676e839ebd178e2c1e6f2f":
      SalesExecutiveId.THE_68676_E839_EBD178_E2_C1_E6_F2_F,
});

enum Status { APPROVED, NOT_UPLOADED, PENDING }

final statusValues = EnumValues({
  "APPROVED": Status.APPROVED,
  "NOT_UPLOADED": Status.NOT_UPLOADED,
  "PENDING": Status.PENDING,
});

enum VerifiedByEnum { JOHN_DOE, SALES_EXECUTIVE }

final verifiedByEnumValues = EnumValues({
  "John Doe": VerifiedByEnum.JOHN_DOE,
  "Sales Executive": VerifiedByEnum.SALES_EXECUTIVE,
});

class DocumentStatus {
  FinanceLetter? kyc;
  FinanceLetter? financeLetter;

  DocumentStatus({this.kyc, this.financeLetter});

  factory DocumentStatus.fromJson(Map<String, dynamic> json) {
    return DocumentStatus(
      kyc: json["kyc"] != null ? FinanceLetter.fromJson(json["kyc"]) : null,
      financeLetter: json["financeLetter"] != null
          ? FinanceLetter.fromJson(json["financeLetter"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "kyc": kyc?.toJson(),
    "financeLetter": financeLetter?.toJson(),
  };
}

class FinanceLetter {
  Status? status;
  VerifiedByEnum? verifiedBy;
  String? verificationNote;
  DateTime? updatedAt;

  FinanceLetter({
    this.status,
    this.verifiedBy,
    this.verificationNote,
    this.updatedAt,
  });

  factory FinanceLetter.fromJson(Map<String, dynamic> json) {
    return FinanceLetter(
      status: statusValues.map[json["status"]],
      verifiedBy: verifiedByEnumValues.map[json["verifiedBy"]],
      verificationNote: json["verificationNote"] as String?,
      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    "status": statusValues.reverse[status],
    "verifiedBy": verifiedByEnumValues.reverse[verifiedBy],
    "verificationNote": verificationNote,
    "updatedAt": updatedAt?.toIso8601String(),
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
