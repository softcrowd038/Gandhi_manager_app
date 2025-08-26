// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/scanned_model_details.dart';

class GetInwardDetailsByQrcode {
  Future<Dio> getDioInstance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<ScannedModelDetails?> getInwardModelDetails(
    BuildContext context,
    String? qrCode,
  ) async {
    try {
      final dio = await getDioInstance();

      final response = await dio.get("inward/qr/$qrCode");

      if (response.statusCode == 200) {
        // print(response.data);
        return ScannedModelDetails.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      String errorMessage = "Something went wrong";
      if (e is DioException) {
        if (e.response != null && e.response?.data != null) {
          errorMessage = e.response?.data['message'] ?? errorMessage;
        } else {
          errorMessage = e.message ?? "";
        }
      } else {
        errorMessage = e.toString();
      }

      debugPrint('Error: $errorMessage');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
      return null;
    }
  }
}
