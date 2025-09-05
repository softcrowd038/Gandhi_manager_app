// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/downpayment_model.dart';

class AddDownpaymentService {
  Future<Dio> getDioInstance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');

    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Map<String, dynamic>?> postAddDownPaymentModel(
    BuildContext context,
    DownpaymentModel downPaymentModel,
  ) async {
    try {
      final dio = await getDioInstance();

      // Debug print to verify all required fields
      print('Booking ID: ${downPaymentModel.bookingId}');
      print('Disbursement Amount: ${downPaymentModel.disbursementAmount}');
      print('DownPayment Expected: ${downPaymentModel.downPaymentExpected}');
      print('Is Deviation: ${downPaymentModel.isDeviation}');

      final response = await dio.post(
        'disbursements',
        data: downPaymentModel.toJson(),
        options: Options(
          validateStatus: (status) =>
              status! < 500, // Don't throw for 400 errors
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Downpayment posted successfully")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigationPage(index: 3)),
        );
        return response.data;
      } else {
        // Handle 400 errors specifically
        final errorData = response.data;
        String errorMessage = "Failed to post Downpayment details";

        if (errorData is Map<String, dynamic>) {
          errorMessage =
              errorData['message'] ??
              errorData['error'] ??
              errorData.toString();
        } else if (errorData is String) {
          errorMessage = errorData;
        }

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMessage)));
        return null;
      }
    } on DioException catch (e) {
      String errorMessage = "Something went wrong";

      if (e.response != null) {
        final errorData = e.response?.data;

        if (errorData is Map<String, dynamic>) {
          errorMessage =
              errorData['message'] ??
              errorData['error'] ??
              "Server error: ${e.response?.statusCode}";
        } else if (errorData is String) {
          errorMessage = errorData;
        } else {
          errorMessage = "Server error: ${e.response?.statusCode}";
        }

        if (errorData is Map<String, dynamic> && errorData['errors'] != null) {
          final errors = errorData['errors'];
          if (errors is Map<String, dynamic>) {
            errorMessage = errors.entries
                .map((entry) => '${entry.key}: ${entry.value}')
                .join('\n');
          }
        }
      } else {
        errorMessage = e.message ?? "Network error";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $errorMessage")));

      return null;
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Unexpected error: $e")));
      return null;
    }
  }
}
