// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/broker_otp_verification_model.dart';
import 'package:provider/provider.dart';

class BrokerOtpVerification {
  Future<Dio> getDioInstance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');

    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Map<String, dynamic>> verifyOTP(
    String otp,
    BuildContext context,
  ) async {
    try {
      final dio = await getDioInstance();
      final bookingFormProvider = Provider.of<BookingFormProvider>(
        context,
        listen: false,
      );

      BrokerOTPVerificationModel otpVerificationModel =
          BrokerOTPVerificationModel(
            brokerId: bookingFormProvider.bookingFormModel.brokerId,
            otp: otp,
          );

      final response = await dio.post(
        '/brokers/verify-otp',
        data: otpVerificationModel.toJson(),
      );

      final responseData = response.data;

      if (response.statusCode == 200 && responseData['success'] != false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "OTP Verified successfully!",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: AppColors.success,
          ),
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
