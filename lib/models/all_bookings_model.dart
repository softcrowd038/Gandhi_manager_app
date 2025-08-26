// ignore_for_file: constant_identifier_names

import 'package:gandhi_tvs/common/app_imports.dart';

AllBookingModel allBookingModelFromJson(String? str) =>
    AllBookingModel.fromJson(json.decode(str ?? ""));

String? allBookingModelToJson(AllBookingModel data) =>
    json.encode(data.toJson());

class AllBookingModel {
  bool? success;
  Data data;

  AllBookingModel({required this.success, required this.data});

  factory AllBookingModel.fromJson(Map<String?, dynamic>? json) =>
      AllBookingModel(
        success: json?["success"],
        data: Data.fromJson(json?["data"]),
      );

  Map<String?, dynamic>? toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  List<Booking> bookings;
  int? total;
  int? pages;
  int? currentPage;

  Data({
    required this.bookings,
    required this.total,
    required this.pages,
    required this.currentPage,
  });

  factory Data.fromJson(Map<String?, dynamic>? json) => Data(
    bookings: List<Booking>.from(
      json?["bookings"].map((x) => Booking.fromJson(x)),
    ),
    total: json?["total"],
    pages: json?["pages"],
    currentPage: json?["currentPage"],
  );

  Map<String?, dynamic>? toJson() => {
    "bookings": List<dynamic>.from(bookings.map((x) => x.toJson())),
    "total": total,
    "pages": pages,
    "currentPage": currentPage,
  };
}

class Booking {
  String? id;
  Model model;
  String bookingType;
  Color color;
  bool? chassisNumberChangeAllowed;
  String customerType;
  bool? isCsd;
  String? gstin;
  String rto;
  String rtoStatus;
  int? rtoAmount;
  bool? hpa;
  int? hypothecationCharges;
  String kycStatus;
  String financeLetterStatus;
  CustomerDetails customerDetails;
  bool? exchange;
  ExchangeDetails? exchangeDetails;
  Payment payment;
  List<Accessory> accessories;
  List<PriceComponent> priceComponents;
  List<Discount> discounts;
  int? accessoriesTotal;
  int? totalAmount;
  int? discountedAmount;
  int? receivedAmount;
  List<dynamic> receipts;
  List<dynamic> ledgerEntries;
  String status;
  String insuranceStatus;
  Branch? branch;
  CreatedBy createdBy;
  CreatedBy? salesExecutive;
  String? formPath;
  bool? formGenerated;
  String? qrCode;
  dynamic pendingUpdates;
  String updateRequestStatus;
  String? updateRequestNote;
  bool? updateRequestSubmitted;
  List<dynamic> chassisNumberHistory;
  List<BrokerLedgerEntry> brokerLedgerEntries;
  int? balanceAmount;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? bookingNumber;
  int? v;
  String? bookingId;
  DocumentStatus documentStatus;
  String? subdealer;
  String? subdealerUser;
  DateTime? approvedAt;
  String? approvedBy;
  String? chassisNumber;
  dynamic batteryNumber;
  dynamic chargerNumber;
  dynamic engineNumber;
  dynamic keyNumber;
  dynamic motorNumber;

  Booking({
    required this.id,
    required this.model,
    required this.bookingType,
    required this.color,
    required this.chassisNumberChangeAllowed,
    required this.customerType,
    required this.isCsd,
    required this.gstin,
    required this.rto,
    required this.rtoStatus,
    this.rtoAmount,
    required this.hpa,
    required this.hypothecationCharges,
    required this.kycStatus,
    required this.financeLetterStatus,
    required this.customerDetails,
    required this.exchange,
    required this.exchangeDetails,
    required this.payment,
    required this.accessories,
    required this.priceComponents,
    required this.discounts,
    required this.accessoriesTotal,
    required this.totalAmount,
    required this.discountedAmount,
    required this.receivedAmount,
    required this.receipts,
    required this.ledgerEntries,
    required this.status,
    required this.insuranceStatus,
    this.branch,
    required this.createdBy,
    this.salesExecutive,
    required this.formPath,
    required this.formGenerated,
    required this.qrCode,
    required this.pendingUpdates,
    required this.updateRequestStatus,
    required this.updateRequestNote,
    required this.updateRequestSubmitted,
    required this.chassisNumberHistory,
    required this.brokerLedgerEntries,
    required this.balanceAmount,
    required this.createdAt,
    required this.updatedAt,
    required this.bookingNumber,
    required this.v,
    required this.bookingId,
    required this.documentStatus,
    this.subdealer,
    this.subdealerUser,
    this.approvedAt,
    this.approvedBy,
    this.chassisNumber,
    this.batteryNumber,
    this.chargerNumber,
    this.engineNumber,
    this.keyNumber,
    this.motorNumber,
  });

  factory Booking.fromJson(Map<String?, dynamic>? json) => Booking(
    id: json?["_id"],
    model: Model.fromJson(json?["model"]),
    bookingType: json?["bookingType"] ?? "BRANCH",
    color: Color.fromJson(json?["color"]),
    chassisNumberChangeAllowed: json?["chassisNumberChangeAllowed"],
    customerType: json?["customerType"] ?? "B2C",
    isCsd: json?["isCSD"],
    gstin: json?["gstin"],
    rto: json?["rto"] ?? "MH",
    rtoStatus: json?["rtoStatus"] ?? "PENDING",
    rtoAmount: json?["rtoAmount"],
    hpa: json?["hpa"],
    hypothecationCharges: json?["hypothecationCharges"],
    kycStatus: json?["kycStatus"] ?? "APPROVED",
    financeLetterStatus: json?["financeLetterStatus"] ?? "APPROVED",
    customerDetails: CustomerDetails.fromJson(json?["customerDetails"]),
    exchange: json?["exchange"],
    exchangeDetails: json?["exchangeDetails"] == null
        ? null
        : ExchangeDetails.fromJson(json?["exchangeDetails"]),
    payment: Payment.fromJson(json?["payment"]),
    accessories: List<Accessory>.from(
      json?["accessories"].map((x) => Accessory.fromJson(x)),
    ),
    priceComponents: List<PriceComponent>.from(
      json?["priceComponents"].map((x) => PriceComponent.fromJson(x)),
    ),
    discounts: List<Discount>.from(
      json?["discounts"].map((x) => Discount.fromJson(x)),
    ),
    accessoriesTotal: json?["accessoriesTotal"],
    totalAmount: json?["totalAmount"],
    discountedAmount: json?["discountedAmount"],
    receivedAmount: json?["receivedAmount"],
    receipts: List<dynamic>.from(json?["receipts"].map((x) => x)),
    ledgerEntries: List<dynamic>.from(json?["ledgerEntries"].map((x) => x)),
    status: json?["status"] ?? "ALLOCATED",
    insuranceStatus: json?["insuranceStatus"] ?? "AWAITING",
    branch: json?["branch"] == null ? null : Branch.fromJson(json?["branch"]),
    createdBy: CreatedBy.fromJson(json?["createdBy"]),
    salesExecutive: json?["salesExecutive"] == null
        ? null
        : CreatedBy.fromJson(json?["salesExecutive"]),
    formPath: json?["formPath"],
    formGenerated: json?["formGenerated"],
    qrCode: json?["qrCode"],
    pendingUpdates: json?["pendingUpdates"],
    updateRequestStatus: json?["updateRequestStatus"] ?? "NONE",
    updateRequestNote: json?["updateRequestNote"],
    updateRequestSubmitted: json?["updateRequestSubmitted"],
    chassisNumberHistory: List<dynamic>.from(
      json?["chassisNumberHistory"].map((x) => x),
    ),
    brokerLedgerEntries: List<BrokerLedgerEntry>.from(
      json?["brokerLedgerEntries"].map((x) => BrokerLedgerEntry.fromJson(x)),
    ),
    balanceAmount: json?["balanceAmount"],
    createdAt: DateTime.parse(json?["createdAt"]),
    updatedAt: DateTime.parse(json?["updatedAt"]),
    bookingNumber: json?["bookingNumber"],
    v: json?["__v"],
    bookingId: json?["id"],
    documentStatus: DocumentStatus.fromJson(json?["documentStatus"]),
    subdealer: json?["subdealer"],
    subdealerUser: json?["subdealerUser"],
    approvedAt: json?["approvedAt"] == null
        ? null
        : DateTime.parse(json?["approvedAt"]),
    approvedBy: json?["approvedBy"],
    chassisNumber: json?["chassisNumber"],
    batteryNumber: json?["batteryNumber"],
    chargerNumber: json?["chargerNumber"],
    engineNumber: json?["engineNumber"],
    keyNumber: json?["keyNumber"],
    motorNumber: json?["motorNumber"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "model": model.toJson(),
    "bookingType": bookingType,
    "color": color.toJson(),
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
    "customerDetails": customerDetails.toJson(),
    "exchange": exchange,
    "exchangeDetails": exchangeDetails?.toJson(),
    "payment": payment.toJson(),
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
    "createdBy": createdBy.toJson(),
    "salesExecutive": salesExecutive?.toJson(),
    "formPath": formPath,
    "formGenerated": formGenerated,
    "qrCode": qrCode,
    "pendingUpdates": pendingUpdates,
    "updateRequestStatus": updateRequestStatus,
    "updateRequestNote": updateRequestNote,
    "updateRequestSubmitted": updateRequestSubmitted,
    "chassisNumberHistory": List<dynamic>.from(
      chassisNumberHistory.map((x) => x),
    ),
    "brokerLedgerEntries": List<dynamic>.from(
      brokerLedgerEntries.map((x) => x.toJson()),
    ),
    "balanceAmount": balanceAmount,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "bookingNumber": bookingNumber,
    "__v": v,
    "id": bookingId,
    "documentStatus": documentStatus.toJson(),
    "subdealer": subdealer,
    "subdealerUser": subdealerUser,
    "approvedAt": approvedAt?.toIso8601String(),
    "approvedBy": approvedBy,
    "chassisNumber": chassisNumber,
    "batteryNumber": batteryNumber,
    "chargerNumber": chargerNumber,
    "engineNumber": engineNumber,
    "keyNumber": keyNumber,
    "motorNumber": motorNumber,
  };
}

class Accessory {
  String? accessory;
  int? price;
  int? discount;
  bool? isAdjustment;

  Accessory({
    required this.accessory,
    required this.price,
    required this.discount,
    required this.isAdjustment,
  });

  factory Accessory.fromJson(Map<String?, dynamic>? json) => Accessory(
    accessory: json?["accessory"],
    price: json?["price"],
    discount: json?["discount"],
    isAdjustment: json?["isAdjustment"],
  );

  Map<String?, dynamic>? toJson() => {
    "accessory": accessory,
    "price": price,
    "discount": discount,
    "isAdjustment": isAdjustment,
  };
}

class Branch {
  String id;
  String name;
  String address;
  String city;
  String state;
  String? pincode;
  String? phone;
  String email;
  String gstNumber;
  bool? isActive;
  String logo1;
  String logo2;
  String createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? openingBalance;
  List<OpeningBalanceHistory> openingBalanceHistory;

  Branch({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.pincode,
    required this.phone,
    required this.email,
    required this.gstNumber,
    required this.isActive,
    required this.logo1,
    required this.logo2,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.openingBalance,
    required this.openingBalanceHistory,
  });

  factory Branch.fromJson(Map<String?, dynamic>? json) => Branch(
    id: json?["_id"] ?? "",
    name: json?["name"] ?? "",
    address: json?["address"] ?? "",
    city: json?["city"] ?? "",
    state: json?["state"] ?? "",
    pincode: json?["pincode"],
    phone: json?["phone"],
    email: json?["email"] ?? "",
    gstNumber: json?["gst_number"] ?? "",
    isActive: json?["is_active"],
    logo1: json?["logo1"] ?? "",
    logo2: json?["logo2"] ?? "",
    createdBy: json?["createdBy"] ?? "",
    createdAt: DateTime.parse(json?["createdAt"]),
    updatedAt: DateTime.parse(json?["updatedAt"]),
    v: json?["__v"],
    openingBalance: json?["opening_balance"],
    openingBalanceHistory: List<OpeningBalanceHistory>.from(
      json?["opening_balance_history"].map(
        (x) => OpeningBalanceHistory.fromJson(x),
      ),
    ),
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "name": name,
    "address": address,
    "city": city,
    "state": state,
    "pincode": pincode,
    "phone": phone,
    "email": email,
    "gst_number": gstNumber,
    "is_active": isActive,
    "logo1": logo1,
    "logo2": logo2,
    "createdBy": createdBy,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "opening_balance": openingBalance,
    "opening_balance_history": List<dynamic>.from(
      openingBalanceHistory.map((x) => x.toJson()),
    ),
  };
}

class OpeningBalanceHistory {
  int? amount;
  String updatedBy;
  String note;
  String id;
  DateTime? date;

  OpeningBalanceHistory({
    required this.amount,
    required this.updatedBy,
    required this.note,
    required this.id,
    required this.date,
  });

  factory OpeningBalanceHistory.fromJson(Map<String?, dynamic>? json) =>
      OpeningBalanceHistory(
        amount: json?["amount"],
        updatedBy: json?["updatedBy"] ?? "",
        note: json?["note"] ?? "",
        id: json?["_id"] ?? "",
        date: DateTime.parse(json?["date"]),
      );

  Map<String?, dynamic>? toJson() => {
    "amount": amount,
    "updatedBy": updatedBy,
    "note": note,
    "_id": id,
    "date": date?.toIso8601String(),
  };
}

class BrokerLedgerEntry {
  String? ledger;
  int? amount;
  String type;
  DateTime? createdAt;
  String? id;

  BrokerLedgerEntry({
    required this.ledger,
    required this.amount,
    required this.type,
    required this.createdAt,
    required this.id,
  });

  factory BrokerLedgerEntry.fromJson(Map<String?, dynamic>? json) =>
      BrokerLedgerEntry(
        ledger: json?["ledger"],
        amount: json?["amount"],
        type: json?["type"] ?? "EXCHANGE_AND_COMMISSION",
        createdAt: DateTime.parse(json?["createdAt"]),
        id: json?["_id"],
      );

  Map<String?, dynamic>? toJson() => {
    "ledger": ledger,
    "amount": amount,
    "type": type,
    "createdAt": createdAt?.toIso8601String(),
    "_id": id,
  };
}

class Color {
  String id;
  String name;

  Color({required this.id, required this.name});

  factory Color.fromJson(Map<String?, dynamic>? json) =>
      Color(id: json?["_id"] ?? "", name: json?["name"] ?? "");

  Map<String?, dynamic>? toJson() => {"_id": id, "name": name};
}

class CreatedBy {
  String? id;
  String name;
  String? email;

  CreatedBy({required this.id, required this.name, required this.email});

  factory CreatedBy.fromJson(Map<String?, dynamic>? json) => CreatedBy(
    id: json?["_id"],
    name: json?["name"] ?? "",
    email: json?["email"],
  );

  Map<String?, dynamic>? toJson() => {"_id": id, "name": name, "email": email};
}

class CustomerDetails {
  String salutation;
  String? name;
  String panNo;
  DateTime? dob;
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

  CustomerDetails({
    required this.salutation,
    required this.name,
    required this.panNo,
    required this.dob,
    required this.occupation,
    required this.address,
    required this.taluka,
    required this.district,
    required this.pincode,
    required this.mobile1,
    required this.mobile2,
    required this.aadharNumber,
    this.nomineeName,
    this.nomineeRelation,
    this.nomineeAge,
  });

  factory CustomerDetails.fromJson(Map<String?, dynamic>? json) =>
      CustomerDetails(
        salutation: json?["salutation"] ?? "",
        name: json?["name"],
        panNo: json?["panNo"] ?? "",
        dob: DateTime.parse(json?["dob"]),
        occupation: json?["occupation"],
        address: json?["address"],
        taluka: json?["taluka"],
        district: json?["district"],
        pincode: json?["pincode"],
        mobile1: json?["mobile1"],
        mobile2: json?["mobile2"],
        aadharNumber: json?["aadharNumber"],
        nomineeName: json?["nomineeName"],
        nomineeRelation: json?["nomineeRelation"],
        nomineeAge: json?["nomineeAge"],
      );

  Map<String?, dynamic>? toJson() => {
    "salutation": salutation,
    "name": name,
    "panNo": panNo,
    "dob": dob?.toIso8601String(),
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
    required this.amount,
    required this.type,
    required this.approvalStatus,
    required this.approvalNote,
    required this.appliedOn,
    this.approvedBy,
  });

  factory Discount.fromJson(Map<String?, dynamic>? json) => Discount(
    amount: json?["amount"],
    type: json?["type"],
    approvalStatus: json?["approvalStatus"],
    approvalNote: json?["approvalNote"],
    appliedOn: DateTime.parse(json?["appliedOn"]),
    approvedBy: json?["approvedBy"],
  );

  Map<String?, dynamic>? toJson() => {
    "amount": amount,
    "type": type,
    "approvalStatus": approvalStatus,
    "approvalNote": approvalNote,
    "appliedOn": appliedOn?.toIso8601String(),
    "approvedBy": approvedBy,
  };
}

class DocumentStatus {
  FinanceLetter kyc;
  FinanceLetter financeLetter;

  DocumentStatus({required this.kyc, required this.financeLetter});

  factory DocumentStatus.fromJson(Map<String?, dynamic>? json) =>
      DocumentStatus(
        kyc: FinanceLetter.fromJson(json?["kyc"]),
        financeLetter: FinanceLetter.fromJson(json?["financeLetter"]),
      );

  Map<String?, dynamic>? toJson() => {
    "kyc": kyc.toJson(),
    "financeLetter": financeLetter.toJson(),
  };
}

class FinanceLetter {
  String status;
  String? verifiedBy;
  String? verificationNote;
  DateTime? updatedAt;

  FinanceLetter({
    required this.status,
    required this.verifiedBy,
    required this.verificationNote,
    required this.updatedAt,
  });

  factory FinanceLetter.fromJson(Map<String?, dynamic>? json) => FinanceLetter(
    status: json?["status"] ?? "APPROVED",
    verifiedBy: json?["verifiedBy"],
    verificationNote: json?["verificationNote"],
    updatedAt: json?["updatedAt"] == null
        ? null
        : DateTime.parse(json?["updatedAt"]),
  );

  Map<String?, dynamic>? toJson() => {
    "status": status,
    "verifiedBy": verifiedBy,
    "verificationNote": verificationNote,
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class ExchangeDetails {
  Broker? broker;
  int? price;
  String vehicleNumber;
  String chassisNumber;
  bool? otpVerified;
  String status;

  ExchangeDetails({
    required this.broker,
    required this.price,
    required this.vehicleNumber,
    required this.chassisNumber,
    required this.otpVerified,
    required this.status,
  });

  factory ExchangeDetails.fromJson(Map<String?, dynamic>? json) =>
      ExchangeDetails(
        broker: json?["broker"] == null
            ? null
            : Broker.fromJson(json?["broker"]),
        price: json?["price"],
        vehicleNumber: json?["vehicleNumber"] ?? "",
        chassisNumber: json?["chassisNumber"] ?? "",
        otpVerified: json?["otpVerified"],
        status: json?["status"] ?? "PENDING",
      );

  Map<String?, dynamic>? toJson() => {
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
  String? mobile;

  Broker({required this.id, required this.name, required this.mobile});

  factory Broker.fromJson(Map<String?, dynamic>? json) =>
      Broker(id: json?["_id"], name: json?["name"], mobile: json?["mobile"]);

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "name": name,
    "mobile": mobile,
  };
}

class Model {
  String id;
  String modelName;
  String type;
  String status;
  List<Price> prices;
  List<String> colors;
  DateTime? createdAt;
  int? modelDiscount;
  DateTime? updatedAt;

  Model({
    required this.id,
    required this.modelName,
    required this.type,
    required this.status,
    required this.prices,
    required this.colors,
    required this.createdAt,
    this.modelDiscount,
    this.updatedAt,
  });

  factory Model.fromJson(Map<String?, dynamic>? json) => Model(
    id: json?["_id"] ?? "",
    modelName: json?["model_name"] ?? "",
    type: json?["type"] ?? "",
    status: json?["status"] ?? "",
    prices: List<Price>.from(json?["prices"].map((x) => Price.fromJson(x))),
    colors: List<String>.from(json?["colors"].map((x) => x.toString())),
    createdAt: DateTime.parse(json?["createdAt"]),
    modelDiscount: json?["model_discount"],
    updatedAt: json?["updated_at"] == null
        ? null
        : DateTime.parse(json?["updated_at"]),
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "model_name": modelName,
    "type": type,
    "status": status,
    "prices": List<dynamic>.from(prices.map((x) => x.toJson())),
    "colors": List<dynamic>.from(colors.map((x) => x)),
    "createdAt": createdAt?.toIso8601String(),
    "model_discount": modelDiscount,
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Price {
  String? subdealerId;
  int? value;
  String headerId;
  String? branchId;
  DateTime? updatedAt;
  DateTime? createdAt;

  Price({
    this.subdealerId,
    this.value,
    required this.headerId,
    required this.branchId,
    this.updatedAt,
    this.createdAt,
  });

  factory Price.fromJson(Map<String?, dynamic>? json) => Price(
    subdealerId: json?["subdealer_id"],
    value: json?["value"],
    headerId: json?["header_id"] ?? "",
    branchId: json?["branch_id"],
    updatedAt: json?["updated_at"] == null
        ? null
        : DateTime.parse(json?["updated_at"]),
    createdAt: json?["created_at"] == null
        ? null
        : DateTime.parse(json?["created_at"]),
  );

  Map<String?, dynamic>? toJson() => {
    "subdealer_id": subdealerId,
    "value": value,
    "header_id": headerId,
    "branch_id": branchId,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
  };
}

class Payment {
  String type;
  Color? financer;
  String? scheme;
  String? emiPlan;
  bool? gcApplicable;
  int? gcAmount;

  Payment({
    required this.type,
    this.financer,
    this.scheme,
    this.emiPlan,
    required this.gcApplicable,
    this.gcAmount,
  });

  factory Payment.fromJson(Map<String?, dynamic>? json) => Payment(
    type: json?["type"] ?? "CASH",
    financer: json?["financer"] == null
        ? null
        : Color.fromJson(json?["financer"]),
    scheme: json?["scheme"],
    emiPlan: json?["emiPlan"],
    gcApplicable: json?["gcApplicable"],
    gcAmount: json?["gcAmount"],
  );

  Map<String?, dynamic>? toJson() => {
    "type": type,
    "financer": financer?.toJson(),
    "scheme": scheme,
    "emiPlan": emiPlan,
    "gcApplicable": gcApplicable,
    "gcAmount": gcAmount,
  };
}

class PriceComponent {
  String header;
  int? originalValue;
  double discountedValue;
  bool? isDiscountable;
  bool? isMandatory;

  PriceComponent({
    required this.header,
    required this.originalValue,
    required this.discountedValue,
    required this.isDiscountable,
    required this.isMandatory,
  });

  factory PriceComponent.fromJson(Map<String?, dynamic>? json) =>
      PriceComponent(
        header: json?["header"] ?? "",
        originalValue: json?["originalValue"],
        discountedValue: json?["discountedValue"]?.toDouble(),
        isDiscountable: json?["isDiscountable"],
        isMandatory: json?["isMandatory"],
      );

  Map<String?, dynamic>? toJson() => {
    "header": header,
    "originalValue": originalValue,
    "discountedValue": discountedValue,
    "isDiscountable": isDiscountable,
    "isMandatory": isMandatory,
  };
}
