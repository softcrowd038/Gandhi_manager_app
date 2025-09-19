// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/inward_model_details.dart';

class InwardedVehicleService {
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

  Future<InwardModelDetails?> getInwardedModels(
    BuildContext context,
    String branchId,
  ) async {
    try {
      final dio = await getDioInstance();

      final response = await dio.get('vehicles/branch/$branchId');

      if (response.statusCode == 200) {
        return InwardModelDetails.fromJson(response.data);
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ Failed to Get Inwarded Models")),
      );
      return null;
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
