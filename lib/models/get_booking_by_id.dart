import 'package:gandhi_tvs/common/app_imports.dart';

GetBookingsByIdModel getBookingsByIdModelFromJson(String? str) =>
    GetBookingsByIdModel.fromJson(json.decode(str ?? ""));

String? getBookingsByIdModelToJson(GetBookingsByIdModel data) =>
    json.encode(data.toJson());

class GetBookingsByIdModel {
  bool? success;
  Data data;

  GetBookingsByIdModel({required this.success, required this.data});

  factory GetBookingsByIdModel.fromJson(Map<String?, dynamic>? json) =>
      GetBookingsByIdModel(
        success: json?["success"],
        data: Data.fromJson(json?["data"]),
      );

  Map<String?, dynamic>? toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  CustomerDetails customerDetails;
  Model model;
  String? bookingType;
  Branch color;
  bool? chassisNumberChangeAllowed;
  String? note;
  String? customerType;
  bool? isCsd;
  String? dealFormStatus;
  String? deliveryChallanStatus;
  String? gstin;
  String? rto;
  String? rtoStatus;
  dynamic rtoAmount;
  bool? hpa;
  int? hypothecationCharges;
  String? kycStatus;
  String? financeLetterStatus;
  bool? exchange;
  ExchangeDetails exchangeDetails;
  Payment payment;
  List<AccessoryElement> accessories;
  List<PriceComponent> priceComponents;
  List<Discount> discounts;
  int? accessoriesTotal;
  double? totalAmount;
  double? discountedAmount;
  int? receivedAmount;
  List<dynamic> receipts;
  List<dynamic> ledgerEntries;
  String? status;
  String? insuranceStatus;
  Branch branch;
  CreatedBy createdBy;
  SalesExecutive salesExecutive;
  String? formPath;
  bool? formGenerated;
  String? qrCode;
  dynamic pendingUpdates;
  String? updateRequestStatus;
  String? updateRequestNote;
  bool? updateRequestSubmitted;
  List<dynamic> chassisNumberHistory;
  List<BrokerLedgerEntry> brokerLedgerEntries;
  double? balanceAmount;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? bookingNumber;
  dynamic vehicle;
  int? totalExchangeCredit;
  PaymentBreakdown paymentBreakdown;
  int? totalReceived;
  int? effectiveReceivedAmount;
  int? totalFinanceDisbursed;
  String? fullCustomerName;
  String? customerId;
  String? id;
  dynamic chassisNumber;
  dynamic batteryNumber;
  dynamic keyNumber;
  dynamic motorNumber;
  dynamic chargerNumber;
  dynamic engineNumber;
  DocumentStatus documentStatus;

  Data({
    required this.customerDetails,
    required this.model,
    required this.bookingType,
    required this.color,
    required this.chassisNumberChangeAllowed,
    required this.note,
    required this.customerType,
    required this.isCsd,
    required this.dealFormStatus,
    required this.deliveryChallanStatus,
    required this.gstin,
    required this.rto,
    required this.rtoStatus,
    required this.rtoAmount,
    required this.hpa,
    required this.hypothecationCharges,
    required this.kycStatus,
    required this.financeLetterStatus,
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
    required this.branch,
    required this.createdBy,
    required this.salesExecutive,
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
    required this.vehicle,
    required this.totalExchangeCredit,
    required this.paymentBreakdown,
    required this.totalReceived,
    required this.effectiveReceivedAmount,
    required this.totalFinanceDisbursed,
    required this.fullCustomerName,
    required this.customerId,
    required this.id,
    required this.chassisNumber,
    required this.batteryNumber,
    required this.keyNumber,
    required this.motorNumber,
    required this.chargerNumber,
    required this.engineNumber,
    required this.documentStatus,
  });

  factory Data.fromJson(Map<String?, dynamic>? json) {
    // Handle rtoAmount which can be double or custom RTO object
    dynamic rtoAmountValue;
    if (json?["rtoAmount"] != null) {
      if (json?["rtoAmount"] is num) {
        rtoAmountValue = json?["rtoAmount"]?.toDouble();
      } else {
        rtoAmountValue = json?["rtoAmount"];
      }
    }

    return Data(
      customerDetails: CustomerDetails.fromJson(json?["customerDetails"]),
      model: Model.fromJson(json?["model"]),
      bookingType: json?["bookingType"],
      color: Branch.fromJson(json?["color"]),
      chassisNumberChangeAllowed: json?["chassisNumberChangeAllowed"],
      note: json?["note"],
      customerType: json?["customerType"],
      isCsd: json?["isCSD"],
      dealFormStatus: json?["dealFormStatus"],
      deliveryChallanStatus: json?["deliveryChallanStatus"],
      gstin: json?["gstin"],
      rto: json?["rto"],
      rtoStatus: json?["rtoStatus"],
      rtoAmount: rtoAmountValue,
      hpa: json?["hpa"],
      hypothecationCharges: json?["hypothecationCharges"],
      kycStatus: json?["kycStatus"],
      financeLetterStatus: json?["financeLetterStatus"],
      exchange: json?["exchange"],
      exchangeDetails: ExchangeDetails.fromJson(json?["exchangeDetails"]),
      payment: Payment.fromJson(json?["payment"]),
      accessories: List<AccessoryElement>.from(
        (json?["accessories"] ?? []).map((x) => AccessoryElement.fromJson(x)),
      ),
      priceComponents: List<PriceComponent>.from(
        (json?["priceComponents"] ?? []).map((x) => PriceComponent.fromJson(x)),
      ),
      discounts: List<Discount>.from(
        (json?["discounts"] ?? []).map((x) => Discount.fromJson(x)),
      ),
      accessoriesTotal: json?["accessoriesTotal"] ?? 0,
      totalAmount: (json?["totalAmount"] ?? 0).toDouble(),
      discountedAmount: (json?["discountedAmount"] ?? 0).toDouble(),
      receivedAmount: json?["receivedAmount"] ?? 0,
      receipts: List<dynamic>.from(json?["receipts"] ?? []),
      ledgerEntries: List<dynamic>.from(json?["ledgerEntries"] ?? []),
      status: json?["status"],
      insuranceStatus: json?["insuranceStatus"],
      branch: Branch.fromJson(json?["branch"]),
      createdBy: CreatedBy.fromJson(json?["createdBy"]),
      salesExecutive: SalesExecutive.fromJson(json?["salesExecutive"]),
      formPath: json?["formPath"],
      formGenerated: json?["formGenerated"] ?? false,
      qrCode: json?["qrCode"],
      pendingUpdates: json?["pendingUpdates"],
      updateRequestStatus: json?["updateRequestStatus"],
      updateRequestNote: json?["updateRequestNote"],
      updateRequestSubmitted: json?["updateRequestSubmitted"] ?? false,
      chassisNumberHistory: List<dynamic>.from(
        json?["chassisNumberHistory"] ?? [],
      ),
      brokerLedgerEntries: List<BrokerLedgerEntry>.from(
        (json?["brokerLedgerEntries"] ?? []).map(
          (x) => BrokerLedgerEntry.fromJson(x),
        ),
      ),
      balanceAmount: (json?["balanceAmount"] ?? 0).toDouble(),
      createdAt: json?["createdAt"] != null
          ? DateTime.parse(json?["createdAt"])
          : null,
      updatedAt: json?["updatedAt"] != null
          ? DateTime.parse(json?["updatedAt"])
          : null,
      bookingNumber: json?["bookingNumber"],
      vehicle: json?["vehicle"],
      totalExchangeCredit: json?["totalExchangeCredit"] ?? 0,
      paymentBreakdown: PaymentBreakdown.fromJson(
        json?["paymentBreakdown"] ?? {},
      ),
      totalReceived: json?["totalReceived"] ?? 0,
      effectiveReceivedAmount: json?["effectiveReceivedAmount"] ?? 0,
      totalFinanceDisbursed: json?["totalFinanceDisbursed"] ?? 0,
      fullCustomerName: json?["fullCustomerName"],
      customerId: json?["customerId"],
      id: json?["id"],
      chassisNumber: json?["chassisNumber"],
      batteryNumber: json?["batteryNumber"],
      keyNumber: json?["keyNumber"],
      motorNumber: json?["motorNumber"],
      chargerNumber: json?["chargerNumber"],
      engineNumber: json?["engineNumber"],
      documentStatus: DocumentStatus.fromJson(json?["documentStatus"] ?? {}),
    );
  }

  Map<String?, dynamic>? toJson() => {
    "customerDetails": customerDetails.toJson(),
    "model": model.toJson(),
    "bookingType": bookingType,
    "color": color.toJson(),
    "chassisNumberChangeAllowed": chassisNumberChangeAllowed,
    "note": note,
    "customerType": customerType,
    "isCSD": isCsd,
    "dealFormStatus": dealFormStatus,
    "deliveryChallanStatus": deliveryChallanStatus,
    "gstin": gstin,
    "rto": rto,
    "rtoStatus": rtoStatus,
    "rtoAmount": rtoAmount,
    "hpa": hpa,
    "hypothecationCharges": hypothecationCharges,
    "kycStatus": kycStatus,
    "financeLetterStatus": financeLetterStatus,
    "exchange": exchange,
    "exchangeDetails": exchangeDetails.toJson(),
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
    "branch": branch.toJson(),
    "createdBy": createdBy.toJson(),
    "salesExecutive": salesExecutive.toJson(),
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
    "vehicle": vehicle,
    "totalExchangeCredit": totalExchangeCredit,
    "paymentBreakdown": paymentBreakdown.toJson(),
    "totalReceived": totalReceived,
    "effectiveReceivedAmount": effectiveReceivedAmount,
    "totalFinanceDisbursed": totalFinanceDisbursed,
    "fullCustomerName": fullCustomerName,
    "customerId": customerId,
    "id": id,
    "chassisNumber": chassisNumber,
    "batteryNumber": batteryNumber,
    "keyNumber": keyNumber,
    "motorNumber": motorNumber,
    "chargerNumber": chargerNumber,
    "engineNumber": engineNumber,
    "documentStatus": documentStatus.toJson(),
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

  factory AccessoryElement.fromJson(Map<String?, dynamic>? json) =>
      AccessoryElement(
        accessory: json?["accessory"] == null
            ? null
            : AccessoryAccessory.fromJson(json?["accessory"]),
        price: json?["price"] ?? 0,
        discount: json?["discount"] ?? 0,
        isAdjustment: json?["isAdjustment"] ?? false,
      );

  Map<String?, dynamic>? toJson() => {
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
  dynamic totalPrice;
  String? accessoryId;

  AccessoryAccessory({
    this.id,
    this.name,
    this.category,
    this.totalPrice,
    this.accessoryId,
  });

  factory AccessoryAccessory.fromJson(Map<String?, dynamic>? json) =>
      AccessoryAccessory(
        id: json?["_id"],
        name: json?["name"],
        category: json?["category"],
        totalPrice: json?["total_price"],
        accessoryId: json?["id"],
      );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "name": name,
    "category": category,
    "total_price": totalPrice,
    "id": accessoryId,
  };
}

class Branch {
  String? id;
  String? name;
  String? address;
  String? branchId;
  String? code;

  Branch({this.id, this.name, this.address, this.branchId, this.code});

  factory Branch.fromJson(Map<String?, dynamic>? json) => Branch(
    id: json?["_id"],
    name: json?["name"],
    address: json?["address"],
    branchId: json?["id"],
    code: json?["code"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "name": name,
    "address": address,
    "id": branchId,
    "code": code,
  };
}

class BrokerLedgerEntry {
  String? ledger;
  int? amount;
  String? type;
  DateTime? createdAt;
  String? id;
  String? brokerLedgerEntryId;

  BrokerLedgerEntry({
    this.ledger,
    this.amount,
    this.type,
    this.createdAt,
    this.id,
    this.brokerLedgerEntryId,
  });

  factory BrokerLedgerEntry.fromJson(Map<String?, dynamic>? json) =>
      BrokerLedgerEntry(
        ledger: json?["ledger"],
        amount: json?["amount"] ?? 0,
        type: json?["type"],
        createdAt: json?["createdAt"] != null
            ? DateTime.parse(json?["createdAt"])
            : null,
        id: json?["_id"],
        brokerLedgerEntryId: json?["id"],
      );

  Map<String?, dynamic>? toJson() => {
    "ledger": ledger,
    "amount": amount,
    "type": type,
    "createdAt": createdAt?.toIso8601String(),
    "_id": id,
    "id": brokerLedgerEntryId,
  };
}

class CreatedBy {
  String? id;
  String? name;
  String? email;
  String? mobile;
  dynamic availableDeviationAmount;
  String? createdById;

  CreatedBy({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.availableDeviationAmount,
    this.createdById,
  });

  factory CreatedBy.fromJson(Map<String?, dynamic>? json) => CreatedBy(
    id: json?["_id"],
    name: json?["name"],
    email: json?["email"],
    mobile: json?["mobile"],
    availableDeviationAmount: json?["availableDeviationAmount"],
    createdById: json?["id"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "availableDeviationAmount": availableDeviationAmount,
    "id": createdById,
  };
}

class CustomerDetails {
  String? custId;
  String? salutation;
  String? name;
  String? panNo;
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
  String? fullName;

  CustomerDetails({
    this.custId,
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

  factory CustomerDetails.fromJson(Map<String?, dynamic>? json) =>
      CustomerDetails(
        custId: json?["custId"],
        salutation: json?["salutation"],
        name: json?["name"],
        panNo: json?["panNo"],
        dob: json?["dob"] != null ? DateTime.parse(json?["dob"]) : null,
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
        fullName: json?["fullName"],
      );

  Map<String?, dynamic>? toJson() => {
    "custId": custId,
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
    "fullName": fullName,
  };
}

class Discount {
  int? amount;
  String? type;
  String? approvalStatus;
  String? approvalNote;
  DateTime? appliedOn;

  Discount({
    this.amount,
    this.type,
    this.approvalStatus,
    this.approvalNote,
    this.appliedOn,
  });

  factory Discount.fromJson(Map<String?, dynamic>? json) => Discount(
    amount: json?["amount"] ?? 0,
    type: json?["type"],
    approvalStatus: json?["approvalStatus"],
    approvalNote: json?["approvalNote"],
    appliedOn: json?["appliedOn"] != null
        ? DateTime.parse(json?["appliedOn"])
        : null,
  );

  Map<String?, dynamic>? toJson() => {
    "amount": amount,
    "type": type,
    "approvalStatus": approvalStatus,
    "approvalNote": approvalNote,
    "appliedOn": appliedOn?.toIso8601String(),
  };
}

class DocumentStatus {
  DealForm dealForm;
  DealForm deliveryChallan;

  DocumentStatus({required this.dealForm, required this.deliveryChallan});

  factory DocumentStatus.fromJson(Map<String?, dynamic>? json) =>
      DocumentStatus(
        dealForm: DealForm.fromJson(json?["dealForm"] ?? {}),
        deliveryChallan: DealForm.fromJson(json?["deliveryChallan"] ?? {}),
      );

  Map<String?, dynamic>? toJson() => {
    "dealForm": dealForm.toJson(),
    "deliveryChallan": deliveryChallan.toJson(),
  };
}

class DealForm {
  String? status;

  DealForm({this.status});

  factory DealForm.fromJson(Map<String?, dynamic>? json) =>
      DealForm(status: json?["status"]);

  Map<String?, dynamic>? toJson() => {"status": status};
}

class ExchangeDetails {
  Branch broker;
  int? price;
  String? vehicleNumber;
  String? chassisNumber;
  bool? otpVerified;
  String? otp;
  DateTime? otpExpiresAt;
  String? status;
  DateTime? completedAt;

  ExchangeDetails({
    required this.broker,
    this.price,
    this.vehicleNumber,
    this.chassisNumber,
    this.otpVerified,
    this.otp,
    this.otpExpiresAt,
    this.status,
    this.completedAt,
  });

  factory ExchangeDetails.fromJson(Map<String?, dynamic>? json) =>
      ExchangeDetails(
        broker: Branch.fromJson(json?["broker"]),
        price: json?["price"] ?? 0,
        vehicleNumber: json?["vehicleNumber"],
        chassisNumber: json?["chassisNumber"],
        otpVerified: json?["otpVerified"] ?? false,
        otp: json?["otp"],
        otpExpiresAt: json?["otpExpiresAt"] != null
            ? DateTime.parse(json?["otpExpiresAt"])
            : null,
        status: json?["status"],
        completedAt: json?["completedAt"] != null
            ? DateTime.parse(json?["completedAt"])
            : null,
      );

  Map<String?, dynamic>? toJson() => {
    "broker": broker.toJson(),
    "price": price,
    "vehicleNumber": vehicleNumber,
    "chassisNumber": chassisNumber,
    "otpVerified": otpVerified,
    "otp": otp,
    "otpExpiresAt": otpExpiresAt?.toIso8601String(),
    "status": status,
    "completedAt": completedAt?.toIso8601String(),
  };
}

class Model {
  String? modelName;
  String? type;
  String? displayName;
  String? id;
  String? name;

  Model({this.modelName, this.type, this.displayName, this.id, this.name});

  factory Model.fromJson(Map<String?, dynamic>? json) => Model(
    modelName: json?["model_name"],
    type: json?["type"],
    displayName: json?["display_name"],
    id: json?["id"],
    name: json?["name"],
  );

  Map<String?, dynamic>? toJson() => {
    "model_name": modelName,
    "type": type,
    "display_name": displayName,
    "id": id,
    "name": name,
  };
}

class Payment {
  String? type;
  Branch? financer; // Made nullable for CASH payments
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

  factory Payment.fromJson(Map<String?, dynamic>? json) => Payment(
    type: json?["type"],
    financer: json?["financer"] != null
        ? Branch.fromJson(json?["financer"])
        : null,
    scheme: json?["scheme"],
    emiPlan: json?["emiPlan"],
    gcApplicable: json?["gcApplicable"] ?? false,
    gcAmount: json?["gcAmount"] ?? 0,
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

class PaymentBreakdown {
  PaymentBreakdown();

  factory PaymentBreakdown.fromJson(Map<String?, dynamic>? json) =>
      PaymentBreakdown();

  Map<String?, dynamic>? toJson() => {};
}

class PriceComponent {
  Header header;
  double? originalValue;
  double? discountedValue;
  bool? isDiscountable;
  bool? isMandatory;

  PriceComponent({
    required this.header,
    this.originalValue,
    this.discountedValue,
    this.isDiscountable,
    this.isMandatory,
  });

  factory PriceComponent.fromJson(Map<String?, dynamic>? json) =>
      PriceComponent(
        header: Header.fromJson(json?["header"]),
        originalValue: (json?["originalValue"] ?? 0).toDouble(),
        discountedValue: (json?["discountedValue"] ?? 0).toDouble(),
        isDiscountable: json?["isDiscountable"] ?? false,
        isMandatory: json?["isMandatory"] ?? false,
      );

  Map<String?, dynamic>? toJson() => {
    "header": header.toJson(),
    "originalValue": originalValue,
    "discountedValue": discountedValue,
    "isDiscountable": isDiscountable,
    "isMandatory": isMandatory,
  };
}

class Header {
  String? id;
  String? headerKey;
  String? headerId;

  Header({this.id, this.headerKey, this.headerId});

  factory Header.fromJson(Map<String?, dynamic>? json) => Header(
    id: json?["_id"],
    headerKey: json?["header_key"],
    headerId: json?["id"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "header_key": headerKey,
    "id": headerId,
  };
}

class SalesExecutive {
  String? id;
  String? name;
  String? email;
  String? mobile;
  Branch branch;

  SalesExecutive({
    this.id,
    this.name,
    this.email,
    this.mobile,
    required this.branch,
  });

  factory SalesExecutive.fromJson(Map<String?, dynamic>? json) =>
      SalesExecutive(
        id: json?["_id"],
        name: json?["name"],
        email: json?["email"],
        mobile: json?["mobile"],
        branch: Branch.fromJson(json?["branch"]),
      );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "mobile": mobile,
    "branch": branch.toJson(),
  };
}
