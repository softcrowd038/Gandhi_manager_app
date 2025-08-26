// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

class BrokerOTPService {
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

  Future<Map<String, dynamic>> sendBrokerOtp(BuildContext context) async {
    try {
      final dio = await getDioInstance();
      final bookingProvider = Provider.of<BookingFormProvider>(
        context,
        listen: false,
      );

      final brokerId = bookingProvider.bookingFormModel.brokerId;

      final response = await dio.post('/brokers/$brokerId/send-otp');

      final responseData = response.data;

      if (response.statusCode == 200 && responseData['success'] != false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "OTP sent successfully!",
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
