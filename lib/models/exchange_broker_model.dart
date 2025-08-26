import 'package:gandhi_tvs/common/app_imports.dart';

ExchangeBrokerModel exchangeBrokerModelFromJson(String str) =>
    ExchangeBrokerModel.fromJson(json.decode(str));

String exchangeBrokerModelToJson(ExchangeBrokerModel data) =>
    json.encode(data.toJson());

// ✅ Main Model
class ExchangeBrokerModel {
  bool? success;
  List<Datum> data;

  ExchangeBrokerModel({this.success, this.data = const []});

  factory ExchangeBrokerModel.fromJson(Map<String, dynamic> json) =>
      ExchangeBrokerModel(
        success: json["success"],
        data: json["data"] != null && json["data"] is List
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data.map((x) => x.toJson()).toList(),
  };
}

class Datum {
  bool? otpRequired;
  String? otp;
  String? otpExpiresAt;
  String? id;
  String? name;
  String? mobile;
  String? email;
  List<BranchElement> branches;
  String? createdBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? brokerId;
  int? v;
  String? datumId;

  Datum({
    this.otpRequired,
    this.otp,
    this.otpExpiresAt,
    this.id,
    this.name,
    this.mobile,
    this.email,
    this.branches = const [],
    this.createdBy,
    this.createdAt,
    this.updatedAt,
    this.brokerId,
    this.v,
    this.datumId,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    otpRequired: json["otp_required"],
    otp: json["otp"],
    otpExpiresAt: json["otpExpiresAt"],
    id: json["_id"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    branches: json["branches"] != null && json["branches"] is List
        ? List<BranchElement>.from(
            json["branches"].map((x) => BranchElement.fromJson(x)),
          )
        : [],
    createdBy: json["createdBy"],
    createdAt: json["createdAt"] != null
        ? DateTime.tryParse(json["createdAt"])
        : null,
    updatedAt: json["updatedAt"] != null
        ? DateTime.tryParse(json["updatedAt"])
        : null,
    brokerId: json["brokerId"],
    v: json["__v"],
    datumId: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "otp_required": otpRequired,
    "otp": otp,
    "otpExpiresAt": otpExpiresAt,
    "_id": id,
    "name": name,
    "mobile": mobile,
    "email": email,
    "branches": branches.map((x) => x.toJson()).toList(),
    "createdBy": createdBy,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "brokerId": brokerId,
    "__v": v,
    "id": datumId,
  };
}

// ✅ Branch Details
class BranchElement {
  BranchBranch? branch;
  AddedBy? addedBy;
  String? commissionType;
  int? fixedCommission;
  bool? isActive;
  DateTime? createdAt;

  BranchElement({
    this.branch,
    this.addedBy,
    this.commissionType,
    this.fixedCommission,
    this.isActive,
    this.createdAt,
  });

  factory BranchElement.fromJson(Map<String, dynamic> json) => BranchElement(
    branch: json["branch"] != null
        ? BranchBranch.fromJson(json["branch"])
        : null,
    addedBy: json["addedBy"] != null ? AddedBy.fromJson(json["addedBy"]) : null,
    commissionType: json["commissionType"],
    fixedCommission: json["fixedCommission"],
    isActive: json["isActive"],
    createdAt: json["createdAt"] != null
        ? DateTime.tryParse(json["createdAt"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "branch": branch?.toJson(),
    "addedBy": addedBy?.toJson(),
    "commissionType": commissionType,
    "fixedCommission": fixedCommission,
    "isActive": isActive,
    "createdAt": createdAt?.toIso8601String(),
  };
}

// ✅ Added By Info
class AddedBy {
  String? id;
  String? name;
  String? email;
  String? addedById;

  AddedBy({this.id, this.name, this.email, this.addedById});

  factory AddedBy.fromJson(Map<String, dynamic> json) => AddedBy(
    id: json["_id"],
    name: json["name"],
    email: json["email"],
    addedById: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "email": email,
    "id": addedById,
  };
}

// ✅ Branch Info
class BranchBranch {
  String? id;
  String? name;
  String? branchId;

  BranchBranch({this.id, this.name, this.branchId});

  factory BranchBranch.fromJson(Map<String, dynamic> json) =>
      BranchBranch(id: json["_id"], name: json["name"], branchId: json["id"]);

  Map<String, dynamic> toJson() => {"_id": id, "name": name, "id": branchId};
}
