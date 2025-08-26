// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:gandhi_tvs/common/app_imports.dart';

class UserLoginService {
  final Dio _dioLogin = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  Future<Map<String, dynamic>> login(
    String mobile,
    BuildContext context,
  ) async {
    try {
      UserLoginModel userLoginModel = UserLoginModel(mobile: mobile);

      final response = await _dioLogin.post(
        '/auth/request-otp',
        data: userLoginModel.toJson(),
      );

      final responseData = response.data;

      if (response.statusCode == 200 && responseData['success'] != false) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => OtpVerification()),
        );
      }

      return responseData;
    } on DioError catch (dioError) {
      if (dioError.response != null && dioError.response?.data != null) {
        return dioError.response?.data;
      } else {
        return {
          'success': false,
          'message': 'Network error occurred. Please try again.',
        };
      }
    } catch (error) {
      return {'success': false, 'message': 'Unexpected error: $error'};
    }
  }
}
