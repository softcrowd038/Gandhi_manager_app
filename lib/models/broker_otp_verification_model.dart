import 'package:gandhi_tvs/common/app_imports.dart';

BrokerOTPVerificationModel oTPVerificationModelFromJson(String str) =>
    BrokerOTPVerificationModel.fromJson(json.decode(str));

String oTPVerificationModelToJson(BrokerOTPVerificationModel data) =>
    json.encode(data.toJson());

class BrokerOTPVerificationModel {
  String? brokerId;
  String? otp;

  BrokerOTPVerificationModel({required this.brokerId, required this.otp});

  factory BrokerOTPVerificationModel.fromJson(Map<String?, dynamic>? json) =>
      BrokerOTPVerificationModel(
        brokerId: json?["brokerId"],
        otp: json?["otp"],
      );

  Map<String?, dynamic>? toJson() => {"brokerId": brokerId, "otp": otp};
}
