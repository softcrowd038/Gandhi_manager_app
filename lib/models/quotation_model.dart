// ignore_for_file: constant_identifier_names

import 'package:gandhi_tvs/common/app_imports.dart';

QuotationResponse quotationResponseFromJson(String str) =>
    QuotationResponse.fromJson(json.decode(str));

String? quotationResponseToJson(QuotationResponse data) =>
    json.encode(data.toJson());

class QuotationResponse {
  String? status;
  Data data;

  QuotationResponse({required this.status, required this.data});

  factory QuotationResponse.fromJson(Map<String?, dynamic>? json) =>
      QuotationResponse(
        status: json?["status"],
        data: Data.fromJson(json?["data"]),
      );

  Map<String?, dynamic>? toJson() => {"status": status, "data": data.toJson()};
}

class Data {
  UserDetails userDetails;
  CustomerDetails customerDetails;
  DateTime expectedDeliveryDate;
  List<AllModel> allModels;
  List<DataAttachment> attachments;
  String? quotationId;
  String? quotationNumber;
  String? pdfUrl;
  List<ModelSpecificOffer> modelSpecificOffers;
  List<AllUniqueOffer> allUniqueOffers;

  Data({
    required this.userDetails,
    required this.customerDetails,
    required this.expectedDeliveryDate,
    required this.allModels,
    required this.attachments,
    required this.quotationId,
    required this.quotationNumber,
    required this.pdfUrl,
    required this.modelSpecificOffers,
    required this.allUniqueOffers,
  });

  factory Data.fromJson(Map<String?, dynamic>? json) => Data(
    userDetails: UserDetails.fromJson(json?["userDetails"]),
    customerDetails: CustomerDetails.fromJson(json?["customerDetails"]),
    expectedDeliveryDate: DateTime.parse(json?["expected_delivery_date"]),
    allModels: List<AllModel>.from(
      json?["AllModels"].map((x) => AllModel.fromJson(x)),
    ),
    attachments: List<DataAttachment>.from(
      json?["attachments"].map((x) => DataAttachment.fromJson(x)),
    ),
    quotationId: json?["quotation_id"],
    quotationNumber: json?["quotation_number"],
    pdfUrl: json?["pdfUrl"],
    modelSpecificOffers: List<ModelSpecificOffer>.from(
      json?["modelSpecificOffers"].map((x) => ModelSpecificOffer.fromJson(x)),
    ),
    allUniqueOffers: List<AllUniqueOffer>.from(
      json?["allUniqueOffers"].map((x) => AllUniqueOffer.fromJson(x)),
    ),
  );

  Map<String?, dynamic>? toJson() => {
    "userDetails": userDetails.toJson(),
    "customerDetails": customerDetails.toJson(),
    "expected_delivery_date":
        "${expectedDeliveryDate.year.toString().padLeft(4, '0')}-${expectedDeliveryDate.month.toString().padLeft(2, '0')}-${expectedDeliveryDate.day.toString().padLeft(2, '0')}",
    "AllModels": List<dynamic>.from(allModels.map((x) => x.toJson())),
    "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
    "quotation_id": quotationId,
    "quotation_number": quotationNumber,
    "pdfUrl": pdfUrl,
    "modelSpecificOffers": List<dynamic>.from(
      modelSpecificOffers.map((x) => x.toJson()),
    ),
    "allUniqueOffers": List<dynamic>.from(
      allUniqueOffers.map((x) => x.toJson()),
    ),
  };
}

class AllModel {
  String? id;
  String? modelName;
  List<Price> prices;
  int? exShowroomPrice;
  String? series;
  DateTime createdAt;
  bool? isBaseModel;

  AllModel({
    required this.id,
    required this.modelName,
    required this.prices,
    required this.exShowroomPrice,
    required this.series,
    required this.createdAt,
    required this.isBaseModel,
  });

  factory AllModel.fromJson(Map<String?, dynamic>? json) => AllModel(
    id: json?["_id"],
    modelName: json?["model_name"],
    prices: List<Price>.from(json?["prices"].map((x) => Price.fromJson(x))),
    exShowroomPrice: json?["ex_showroom_price"],
    series: json?["series"],
    createdAt: DateTime.parse(json?["createdAt"]),
    isBaseModel: json?["is_base_model"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "model_name": modelName,
    "prices": List<dynamic>.from(prices.map((x) => x.toJson())),
    "ex_showroom_price": exShowroomPrice,
    "series": series,
    "createdAt": createdAt.toIso8601String(),
    "is_base_model": isBaseModel,
  };
}

class Price {
  int? value;
  String? headerKey;
  CategoryKey? categoryKey;
  int? priority;
  Metadata metadata;
  Id? branchId;

  Price({
    required this.value,
    required this.headerKey,
    required this.categoryKey,
    required this.priority,
    required this.metadata,
    required this.branchId,
  });

  factory Price.fromJson(Map<String?, dynamic>? json) => Price(
    value: json?["value"],
    headerKey: json?["header_key"],
    categoryKey: categoryKeyValues.map[json?["category_key"]],
    priority: json?["priority"],
    metadata: Metadata.fromJson(json?["metadata"]),
    branchId: idValues.map[json?["branch_id"]],
  );

  Map<String?, dynamic>? toJson() => {
    "value": value,
    "header_key": headerKey,
    "category_key": categoryKeyValues.reverse[categoryKey],
    "priority": priority,
    "metadata": metadata.toJson(),
    "branch_id": idValues.reverse[branchId],
  };
}

enum Id { THE_6821_E067_EB1_C809_E0_D7_EC96_E }

final idValues = EnumValues({
  "6821e067eb1c809e0d7ec96e": Id.THE_6821_E067_EB1_C809_E0_D7_EC96_E,
});

enum CategoryKey { ACCESORIES, ADD_O_NSERVICES, VEHICLE_PRICE }

final categoryKeyValues = EnumValues({
  "Accesories": CategoryKey.ACCESORIES,
  "AddONservices": CategoryKey.ADD_O_NSERVICES,
  "vehicle_price": CategoryKey.VEHICLE_PRICE,
});

class Metadata {
  int? pageNo;
  String? hsnCode;
  String? gstRate;

  Metadata({
    required this.pageNo,
    required this.hsnCode,
    required this.gstRate,
  });

  factory Metadata.fromJson(Map<String?, dynamic>? json) => Metadata(
    pageNo: json?["page_no"],
    hsnCode: json?["hsn_code"],
    gstRate: json?["gst_rate"],
  );

  Map<String?, dynamic>? toJson() => {
    "page_no": pageNo,
    "hsn_code": hsnCode,
    "gst_rate": gstRate,
  };
}

class AllUniqueOffer {
  String? id;
  String? title;
  String? description;
  String? image;
  String? url;
  DateTime createdAt;
  bool? applyToAllModels;
  List<dynamic> applicableModels;

  AllUniqueOffer({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.url,
    required this.createdAt,
    required this.applyToAllModels,
    required this.applicableModels,
  });

  factory AllUniqueOffer.fromJson(Map<String?, dynamic>? json) =>
      AllUniqueOffer(
        id: json?["_id"],
        title: json?["title"],
        description: json?["description"],
        image: json?["image"],
        url: json?["url"],
        createdAt: DateTime.parse(json?["createdAt"]),
        applyToAllModels: json?["applyToAllModels"],
        applicableModels: List<dynamic>.from(
          json?["applicableModels"].map((x) => x),
        ),
      );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "image": image,
    "url": url,
    "createdAt": createdAt.toIso8601String(),
    "applyToAllModels": applyToAllModels,
    "applicableModels": List<dynamic>.from(applicableModels.map((x) => x)),
  };
}

class DataAttachment {
  String? id;
  String? title;
  String? description;
  bool? isForAllModels;
  List<ApplicableModel> applicableModels;
  List<AttachmentAttachment> attachments;
  CreatedBy createdBy;
  DateTime createdAt;

  DataAttachment({
    required this.id,
    required this.title,
    required this.description,
    required this.isForAllModels,
    required this.applicableModels,
    required this.attachments,
    required this.createdBy,
    required this.createdAt,
  });

  factory DataAttachment.fromJson(Map<String?, dynamic>? json) =>
      DataAttachment(
        id: json?["_id"],
        title: json?["title"],
        description: json?["description"],
        isForAllModels: json?["isForAllModels"],
        applicableModels: List<ApplicableModel>.from(
          json?["applicableModels"].map((x) => ApplicableModel.fromJson(x)),
        ),
        attachments: List<AttachmentAttachment>.from(
          json?["attachments"].map((x) => AttachmentAttachment.fromJson(x)),
        ),
        createdBy: CreatedBy.fromJson(json?["createdBy"]),
        createdAt: DateTime.parse(json?["createdAt"]),
      );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "isForAllModels": isForAllModels,
    "applicableModels": List<dynamic>.from(
      applicableModels.map((x) => x.toJson()),
    ),
    "attachments": List<dynamic>.from(attachments.map((x) => x.toJson())),
    "createdBy": createdBy.toJson(),
    "createdAt": createdAt.toIso8601String(),
  };
}

class ApplicableModel {
  String? id;
  String? modelName;

  ApplicableModel({required this.id, required this.modelName});

  factory ApplicableModel.fromJson(Map<String?, dynamic>? json) =>
      ApplicableModel(id: json?["_id"], modelName: json?["model_name"]);

  Map<String?, dynamic>? toJson() => {"_id": id, "model_name": modelName};
}

class AttachmentAttachment {
  String? type;
  String? url;

  AttachmentAttachment({required this.type, required this.url});

  factory AttachmentAttachment.fromJson(Map<String?, dynamic>? json) =>
      AttachmentAttachment(type: json?["type"], url: json?["url"]);

  Map<String?, dynamic>? toJson() => {"type": type, "url": url};
}

class CreatedBy {
  String? id;
  String? email;

  CreatedBy({required this.id, required this.email});

  factory CreatedBy.fromJson(Map<String?, dynamic>? json) =>
      CreatedBy(id: json?["_id"], email: json?["email"]);

  Map<String?, dynamic>? toJson() => {"_id": id, "email": email};
}

class CustomerDetails {
  String? id;
  String? name;
  String? address;
  String? taluka;
  String? district;
  String? mobile1;
  String? mobile2;
  bool? financeNeeded;
  DateTime createdAt;

  CustomerDetails({
    required this.id,
    required this.name,
    required this.address,
    required this.taluka,
    required this.district,
    required this.mobile1,
    required this.mobile2,
    required this.financeNeeded,
    required this.createdAt,
  });

  factory CustomerDetails.fromJson(Map<String?, dynamic>? json) =>
      CustomerDetails(
        id: json?["_id"],
        name: json?["name"],
        address: json?["address"],
        taluka: json?["taluka"],
        district: json?["district"],
        mobile1: json?["mobile1"],
        mobile2: json?["mobile2"],
        financeNeeded: json?["finance_needed"],
        createdAt: DateTime.parse(json?["createdAt"]),
      );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "name": name,
    "address": address,
    "taluka": taluka,
    "district": district,
    "mobile1": mobile1,
    "mobile2": mobile2,
    "finance_needed": financeNeeded,
    "createdAt": createdAt.toIso8601String(),
  };
}

class ModelSpecificOffer {
  String? modelId;
  String? modelName;
  List<Offer> offers;

  ModelSpecificOffer({
    required this.modelId,
    required this.modelName,
    required this.offers,
  });

  factory ModelSpecificOffer.fromJson(Map<String?, dynamic>? json) =>
      ModelSpecificOffer(
        modelId: json?["model_id"],
        modelName: json?["model_name"],
        offers: List<Offer>.from(json?["offers"].map((x) => Offer.fromJson(x))),
      );

  Map<String?, dynamic>? toJson() => {
    "model_id": modelId,
    "model_name": modelName,
    "offers": List<dynamic>.from(offers.map((x) => x.toJson())),
  };
}

class Offer {
  String? id;
  String? title;
  String? description;
  String? image;
  String? url;
  DateTime createdAt;

  Offer({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.url,
    required this.createdAt,
  });

  factory Offer.fromJson(Map<String?, dynamic>? json) => Offer(
    id: json?["_id"],
    title: json?["title"],
    description: json?["description"],
    image: json?["image"],
    url: json?["url"],
    createdAt: DateTime.parse(json?["createdAt"]),
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "title": title,
    "description": description,
    "image": image,
    "url": url,
    "createdAt": createdAt.toIso8601String(),
  };
}

class UserDetails {
  String? id;
  String? username;
  String? email;
  String? mobile;
  String? fullName;
  Branch branch;
  Role role;

  UserDetails({
    required this.id,
    required this.username,
    required this.email,
    required this.mobile,
    required this.fullName,
    required this.branch,
    required this.role,
  });

  factory UserDetails.fromJson(Map<String?, dynamic>? json) => UserDetails(
    id: json?["_id"],
    username: json?["username"],
    email: json?["email"],
    mobile: json?["mobile"],
    fullName: json?["full_name"],
    branch: Branch.fromJson(json?["branch"]),
    role: Role.fromJson(json?["role"]),
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "username": username,
    "email": email,
    "mobile": mobile,
    "full_name": fullName,
    "branch": branch.toJson(),
    "role": role.toJson(),
  };
}

class Branch {
  Id? id;
  String? name;
  String? address;
  String? city;
  String? state;
  String? pincode;
  String? phone;
  String? email;
  String? gstNumber;
  bool? isActive;

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
  });

  factory Branch.fromJson(Map<String?, dynamic>? json) => Branch(
    id: idValues.map[json?["_id"]],
    name: json?["name"],
    address: json?["address"],
    city: json?["city"],
    state: json?["state"],
    pincode: json?["pincode"],
    phone: json?["phone"],
    email: json?["email"],
    gstNumber: json?["gst_number"],
    isActive: json?["is_active"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": idValues.reverse[id],
    "name": name,
    "address": address,
    "city": city,
    "state": state,
    "pincode": pincode,
    "phone": phone,
    "email": email,
    "gst_number": gstNumber,
    "is_active": isActive,
  };
}

class Role {
  String? id;
  String? name;

  Role({required this.id, required this.name});

  factory Role.fromJson(Map<String?, dynamic>? json) =>
      Role(id: json?["_id"], name: json?["name"]);

  Map<String?, dynamic>? toJson() => {"_id": id, "name": name};
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
