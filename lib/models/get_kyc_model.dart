import 'package:gandhi_tvs/common/app_imports.dart';

GetKycModel getKycModelFromJson(String? str) =>
    GetKycModel.fromJson(json.decode(str ?? ""));

String? getKycModelToJson(GetKycModel data) => json.encode(data.toJson());

class GetKycModel {
  bool? success;
  Data data;

  GetKycModel({required this.success, required this.data});

  factory GetKycModel.fromJson(Map<String?, dynamic>? json) => GetKycModel(
    success: json?["success"],
    data: Data.fromJson(json?["data"]),
  );

  Map<String?, dynamic>? toJson() => {
    "success": success,
    "data": data.toJson(),
  };
}

class Data {
  BookingDetails bookingDetails;
  KycDocuments kycDocuments;

  Data({required this.bookingDetails, required this.kycDocuments});

  factory Data.fromJson(Map<String?, dynamic>? json) => Data(
    bookingDetails: BookingDetails.fromJson(json?["bookingDetails"]),
    kycDocuments: KycDocuments.fromJson(json?["kycDocuments"]),
  );

  Map<String?, dynamic>? toJson() => {
    "bookingDetails": bookingDetails.toJson(),
    "kycDocuments": kycDocuments.toJson(),
  };
}

class BookingDetails {
  String? bookingId;
  String? bookingNumber;
  String? customerName;
  Model model;
  Color color;
  Branch branch;

  BookingDetails({
    required this.bookingId,
    required this.bookingNumber,
    required this.customerName,
    required this.model,
    required this.color,
    required this.branch,
  });

  factory BookingDetails.fromJson(Map<String?, dynamic>? json) =>
      BookingDetails(
        bookingId: json?["bookingId"],
        bookingNumber: json?["bookingNumber"],
        customerName: json?["customerName"],
        model: Model.fromJson(json?["model"]),
        color: Color.fromJson(json?["color"]),
        branch: Branch.fromJson(json?["branch"]),
      );

  Map<String?, dynamic>? toJson() => {
    "bookingId": bookingId,
    "bookingNumber": bookingNumber,
    "customerName": customerName,
    "model": model.toJson(),
    "color": color.toJson(),
    "branch": branch.toJson(),
  };
}

class Branch {
  String? id;
  String? name;
  String? branchId;

  Branch({required this.id, required this.name, required this.branchId});

  factory Branch.fromJson(Map<String?, dynamic>? json) =>
      Branch(id: json?["_id"], name: json?["name"], branchId: json?["id"]);

  Map<String?, dynamic>? toJson() => {"_id": id, "name": name, "id": branchId};
}

class Color {
  String? name;
  String? id;

  Color({required this.name, required this.id});

  factory Color.fromJson(Map<String?, dynamic>? json) =>
      Color(name: json?["name"], id: json?["id"]);

  Map<String?, dynamic>? toJson() => {"name": name, "id": id};
}

class Model {
  String? modelName;
  String? displayName;
  String? id;

  Model({required this.modelName, required this.displayName, required this.id});

  factory Model.fromJson(Map<String?, dynamic>? json) => Model(
    modelName: json?["model_name"],
    displayName: json?["display_name"],
    id: json?["id"],
  );

  Map<String?, dynamic>? toJson() => {
    "model_name": modelName,
    "display_name": displayName,
    "id": id,
  };
}

class KycDocuments {
  String? id;
  AadharBack aadharFront;
  AadharBack aadharBack;
  AadharBack panCard;
  AadharBack vPhoto;
  AadharBack chasisNoPhoto;
  AadharBack addressProof1;
  AadharBack addressProof2;
  String? documentPdf;
  String? kycDocumentsId;

  KycDocuments({
    required this.id,
    required this.aadharFront,
    required this.aadharBack,
    required this.panCard,
    required this.vPhoto,
    required this.chasisNoPhoto,
    required this.addressProof1,
    required this.addressProof2,
    required this.documentPdf,
    required this.kycDocumentsId,
  });

  factory KycDocuments.fromJson(Map<String?, dynamic>? json) => KycDocuments(
    id: json?["_id"],
    aadharFront: AadharBack.fromJson(json?["aadharFront"]),
    aadharBack: AadharBack.fromJson(json?["aadharBack"]),
    panCard: AadharBack.fromJson(json?["panCard"]),
    vPhoto: AadharBack.fromJson(json?["vPhoto"]),
    chasisNoPhoto: AadharBack.fromJson(json?["chasisNoPhoto"]),
    addressProof1: AadharBack.fromJson(json?["addressProof1"]),
    addressProof2: AadharBack.fromJson(json?["addressProof2"]),
    documentPdf: json?["documentPdf"],
    kycDocumentsId: json?["id"],
  );

  Map<String?, dynamic>? toJson() => {
    "_id": id,
    "aadharFront": aadharFront.toJson(),
    "aadharBack": aadharBack.toJson(),
    "panCard": panCard.toJson(),
    "vPhoto": vPhoto.toJson(),
    "chasisNoPhoto": chasisNoPhoto.toJson(),
    "addressProof1": addressProof1.toJson(),
    "addressProof2": addressProof2.toJson(),
    "documentPdf": documentPdf,
    "id": kycDocumentsId,
  };
}

class AadharBack {
  String? original;
  String? pdf;
  String? mimetype;
  String? originalname;

  AadharBack({
    required this.original,
    required this.pdf,
    required this.mimetype,
    required this.originalname,
  });

  factory AadharBack.fromJson(Map<String?, dynamic>? json) => AadharBack(
    original: json?["original"],
    pdf: json?["pdf"],
    mimetype: json?["mimetype"],
    originalname: json?["originalname"],
  );

  Map<String?, dynamic>? toJson() => {
    "original": original,
    "pdf": pdf,
    "mimetype": mimetype,
    "originalname": originalname,
  };
}
