import 'package:gandhi_tvs/common/app_imports.dart';

class KYCModel {
  String? aadharFront;
  String? aadharBack;
  String? panCard;
  String? vPhoto;
  String? chasisNoPhoto;
  String? addressProof1;
  String? addressProof2;

  KYCModel({
    this.aadharFront,
    this.aadharBack,
    this.panCard,
    this.vPhoto,
    this.chasisNoPhoto,
    this.addressProof1,
    this.addressProof2,
  });

  Map<String, dynamic> toJson() {
    return {
      "aadharFront": aadharFront,
      "aadharBack": aadharBack,
      "panCard": panCard,
      "vPhoto": vPhoto,
      "chasisNoPhoto": chasisNoPhoto,
      "addressProof1": addressProof1,
      "addressProof2": addressProof2,
    };
  }

  Future<FormData> toFormData() async {
    final formMap = <String, dynamic>{};

    if (aadharFront != null && await File(aadharFront!).exists()) {
      formMap["aadharFront"] = await MultipartFile.fromFile(aadharFront!);
    } else if (aadharFront != null) {
      throw Exception("Aadhar Front file does not exist at path: $aadharFront");
    }

    if (aadharBack != null && await File(aadharBack!).exists()) {
      formMap["aadharBack"] = await MultipartFile.fromFile(aadharBack!);
    } else if (aadharBack != null) {
      throw Exception("Aadhar Back file does not exist at path: $aadharBack");
    }

    if (panCard != null && await File(panCard!).exists()) {
      formMap["panCard"] = await MultipartFile.fromFile(panCard!);
    } else if (panCard != null) {
      throw Exception("Pan Card file does not exist at path: $panCard");
    }

    if (vPhoto != null && await File(vPhoto!).exists()) {
      formMap["vPhoto"] = await MultipartFile.fromFile(vPhoto!);
    } else if (vPhoto != null) {
      throw Exception("Vehicle Photo file does not exist at path: $vPhoto");
    }

    if (chasisNoPhoto != null && await File(chasisNoPhoto!).exists()) {
      formMap["chasisNoPhoto"] = await MultipartFile.fromFile(chasisNoPhoto!);
    } else if (chasisNoPhoto != null) {
      throw Exception(
        "Chasis No Photo file does not exist at path: $chasisNoPhoto",
      );
    }

    if (addressProof1 != null && await File(addressProof1!).exists()) {
      formMap["addressProof1"] = await MultipartFile.fromFile(addressProof1!);
    } else if (addressProof1 != null) {
      throw Exception(
        "Address Proof 1 file does not exist at path: $addressProof1",
      );
    }

    if (addressProof2 != null && await File(addressProof2!).exists()) {
      formMap["addressProof2"] = await MultipartFile.fromFile(addressProof2!);
    } else if (addressProof2 != null) {
      throw Exception(
        "Address Proof 2 file does not exist at path: $addressProof2",
      );
    }

    return FormData.fromMap(formMap);
  }

  factory KYCModel.fromJson(Map<String, dynamic> json) {
    return KYCModel(
      aadharFront: json["aadharFront"]?.toString(),
      aadharBack: json["aadharBack"]?.toString(),
      panCard: json["panCard"]?.toString(),
      vPhoto: json["vPhoto"]?.toString(),
      chasisNoPhoto: json["chasisNoPhoto"]?.toString(),
      addressProof1: json["addressProof1"]?.toString(),
      addressProof2: json["addressProof2"]?.toString(),
    );
  }
}
