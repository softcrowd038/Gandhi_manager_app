// ignore_for_file: public_member_api_docs, sort_constructors_first

class BookingFormModel {
  String modelId;
  String modelColor;
  String customerType;
  List<String> optionalComponents;
  String gstin;
  String rtoType;
  String branch;
  int rtoAmount;
  String salesExecutive;
  String saluation;
  String customerName;
  String customerPanNo;
  String customerDob;
  String customerOccupation;
  String customerAddress;
  String customerTaluka;
  String customerDistrict;
  String customerPincode;
  String customerMobile1;
  String customerMobile2;
  String customerAadharNumber;
  String nomineeName;
  String nomineeRelation;
  int nomineeAge;

  String paymentType;
  String financerId;
  String scheme;
  String emiPlan;
  bool gcApplicable;
  int gcAmount;

  String discountType;
  int discountValue;

  List<String> accessoryIds;

  bool hpa;

  bool isExchange;
  String brokerId;
  int exchangePrice;
  String otp;
  String note;
  String vehicleNumber;
  String chassisNumber;

  BookingFormModel({
    this.modelId = '',
    this.modelColor = '',
    this.customerType = '',
    this.optionalComponents = const [],
    this.gstin = '',
    this.rtoType = '',
    this.branch = '',
    this.rtoAmount = 0,
    this.salesExecutive = '',
    this.saluation = '',
    this.customerName = '',
    this.customerPanNo = '',
    this.customerDob = '',
    this.customerOccupation = '',
    this.customerAddress = '',
    this.customerTaluka = '',
    this.customerDistrict = '',
    this.customerPincode = '',
    this.customerMobile1 = '',
    this.customerMobile2 = '',
    this.customerAadharNumber = '',
    this.nomineeName = "",
    this.nomineeRelation = '',
    this.nomineeAge = 0,
    this.paymentType = '',
    this.financerId = '',
    this.scheme = '',
    this.emiPlan = '',
    this.gcApplicable = false,
    this.gcAmount = 0,
    this.discountType = '',
    this.discountValue = 0,
    this.accessoryIds = const [],
    this.hpa = false,
    this.isExchange = false,
    this.brokerId = '',
    this.exchangePrice = 0,
    this.otp = '',
    this.note = '',
    this.vehicleNumber = '',
    this.chassisNumber = '',
  });

  Map<String, dynamic> toJson() {
    return {
      "model_id": modelId,
      "model_color": modelColor,
      "customer_type": customerType,
      "gstin": gstin,
      "rto_type": rtoType,
      "branch": branch,
      "rto_amount": rtoAmount,
      "sales_executive": salesExecutive,
      "optionalComponents": optionalComponents,
      "customer_details": {
        "salutation": saluation,
        "name": customerName,
        "pan_no": customerPanNo,
        "dob": customerDob,
        "occupation": customerOccupation,
        "address": customerAddress,
        "taluka": customerTaluka,
        "district": customerDistrict,
        "pincode": customerPincode,
        "mobile1": customerMobile1,
        "mobile2": customerMobile2,
        "aadhar_number": customerAadharNumber,
        "nomineeName": nomineeName,
        "nomineeRelation": nomineeRelation,
        "nomineeAge": nomineeAge,
      },
      "payment": {
        "type": paymentType,
        "financer_id": financerId,
        "scheme": scheme,
        "emi_plan": emiPlan,
        "gc_applicable": gcApplicable,
        "gc_amount": gcAmount,
      },
      "discount": {"type": discountType, "value": discountValue},
      "accessories": {
        "selected": accessoryIds.map((id) => {"id": id}).toList(),
      },
      "hpa": hpa,
      "note": note,
      "exchange": {
        "is_exchange": isExchange,
        "broker_id": brokerId,
        "exchange_price": exchangePrice,
        "vehicle_number": vehicleNumber,
        "chassis_number": chassisNumber,
        "otp": otp,
      },
    };
  }
}
