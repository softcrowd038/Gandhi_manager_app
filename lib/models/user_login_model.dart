import 'package:gandhi_tvs/common/app_imports.dart';

UserLoginModel userLoginModelFromJson(String str) =>
    UserLoginModel.fromJson(json.decode(str));

String userLoginModelToJson(UserLoginModel data) => json.encode(data.toJson());

class UserLoginModel {
  String? mobile;

  UserLoginModel({required this.mobile});

  factory UserLoginModel.fromJson(Map<String?, dynamic>? json) =>
      UserLoginModel(mobile: json?["mobile"]);

  Map<String?, dynamic>? toJson() => {"mobile": mobile};
}
