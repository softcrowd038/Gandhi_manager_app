import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

class OtpVerificationService {
  final Dio _dioLogin = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  Future<Map<String, dynamic>> verifyOTP(
    String otp,
    BuildContext context,
  ) async {
    try {
      final mobileProvider = Provider.of<UserLoginProvider>(
        context,
        listen: false,
      );

      OTPVerificationModel otpVerificationModel = OTPVerificationModel(
        mobile: mobileProvider.mobile,
        otp: otp,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final response = await _dioLogin.post(
        '/auth/verify-otp',
        data: otpVerificationModel.toJson(),
      );

      final responseData = response.data;

      if (response.statusCode == 200 && responseData['success'] != false) {
        // Safe handling of potentially null values
        final token = responseData['token']?.toString();
        final userId = responseData['user']?['id']?.toString();
        final branch = responseData['user']?['branch']?.toString();

        if (token != null) {
          prefs.setString('token', token);
        }

        if (userId != null) {
          prefs.setString('user_id', userId);
        }

        if (branch != null) {
          prefs.setString('branch', branch);
        } else {
          prefs.setString('branch', '');
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigationPage(index: 0)),
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
