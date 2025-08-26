import 'package:gandhi_tvs/common/app_imports.dart';

OTPVerificationModel oTPVerificationModelFromJson(String str) =>
    OTPVerificationModel.fromJson(json.decode(str));

String oTPVerificationModelToJson(OTPVerificationModel data) =>
    json.encode(data.toJson());

class OTPVerificationModel {
  String? mobile;
  String? otp;

  OTPVerificationModel({required this.mobile, required this.otp});

  factory OTPVerificationModel.fromJson(Map<String?, dynamic>? json) =>
      OTPVerificationModel(mobile: json?["mobile"], otp: json?["otp"]);

  Map<String?, dynamic>? toJson() => {"mobile": mobile, "otp": otp};
}
