// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/kyc_model.dart';

class PostKycService {
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

  Future<Map<String, dynamic>?> postKYCDocumentModel(
    BuildContext context,
    KYCModel kycModel,
    String? bookingId,
  ) async {
    try {
      final dio = await getDioInstance();

      if (bookingId == null || bookingId.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Booking ID is missing")));
        return null;
      }

      final formData = await kycModel.toFormData();

      final response = await dio.post('kyc/$bookingId/submit', data: formData);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigationPage(index: 3)),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("KYC documents posted successfully")),
        );
        return response.data;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Failed to post KYC documents: ${response.statusCode}",
            ),
          ),
        );
        return null;
      }
    } catch (e) {
      String errorMessage = "Something went wrong";
      print(e);
      if (e is DioException) {
        if (e.response != null && e.response?.data != null) {
          if (e.response?.data is Map<String, dynamic>) {
            errorMessage = e.response?.data['message'] ?? errorMessage;
          } else if (e.response?.data is String) {
            errorMessage = e.response?.data;
          } else {
            errorMessage = e.response?.data.toString() ?? "";
          }
        } else {
          errorMessage = e.message ?? "";
        }
      } else {
        errorMessage = e.toString();
      }
      print(errorMessage);
      print(e);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));

      return null;
    }
  }
}
