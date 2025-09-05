// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/get_chassis_numbers.dart';

class GetChassisNumbersService {
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

  Future<GetChassisNumberModel?> getChassisNumber(
    BuildContext context,
    String? modelId,
    String? colorId,
  ) async {
    try {
      final dio = await getDioInstance();

      final response = await dio.get(
        "vehicles/model/$modelId/$colorId/chassis-numbers",
      );

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return GetChassisNumberModel.fromJson(response.data);
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      String? errorMessage = "Something went wrong";
      if (e is DioException) {
        if (e.response != null) {
          if (e.response!.data is Map) {
            errorMessage = e.response!.data['message'] ?? errorMessage;
          } else if (e.response!.data is String) {
            errorMessage = e.response!.data;
          }
        } else {
          errorMessage = e.message ?? e.toString();
        }
      } else {
        errorMessage = e.toString();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(errorMessage ?? ""),
        ),
      );

      return null;
    }
  }
}
