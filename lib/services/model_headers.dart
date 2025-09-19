// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/model_headers.dart';

class ModelHeadersService {
  Future<Dio> getDioInstance() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final token = sharedPreferences.getString('token');
    final branchId = sharedPreferences.getString('branch');

    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        queryParameters: {'branch_id': branchId},
      ),
    );
  }

  Future<ModelHeaders?> getModelHeaders(
    BuildContext context,
    String? modelId,
  ) async {
    try {
      final dio = await getDioInstance();
      final response = await dio.get('models/$modelId/with-prices');

      if (response.statusCode == 200) {
        return ModelHeaders.fromJson(response.data);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("❌ Failed to Get Prices")));
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(errorMessage)),
      );
      return null;
    }
  }
}
