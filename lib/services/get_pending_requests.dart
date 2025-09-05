// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/pending_update_model.dart';

class GetPendingRequestsService {
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

  Future<PendingUpdateModel?> getPendingRequests(
    BuildContext context,
    String? bookingId,
  ) async {
    try {
      final dio = await getDioInstance();

      final response = await dio.get("bookings/$bookingId/pending-update");

      if (response.statusCode == 200) {
        return PendingUpdateModel.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      String? errorMessage = "Something went wrong";
      if (e is DioException) {
        if (e.response != null || e.response?.data != null) {
          errorMessage = e.response?.data['message'] ?? errorMessage;
        } else {
          errorMessage = e.message ?? "";
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
