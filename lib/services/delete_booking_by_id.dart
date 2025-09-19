// DeleteBookingService
// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';

class DeleteBookingService {
  Future<Dio> getDioInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';

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

  Future<bool> deleteBookingById(BuildContext context, String? id) async {
    try {
      if (id == null || id.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid booking ID'),
            backgroundColor: AppColors.error,
          ),
        );
        return false;
      }

      final dio = await getDioInstance();
      final response = await dio.delete('bookings/$id');

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Booking Deleted Successfully'),
            backgroundColor: AppColors.success,
          ),
        );
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete Booking'),
            backgroundColor: AppColors.error,
          ),
        );
        return false;
      }
    } catch (e) {
      String errorMessage = "Something went wrong";

      if (e is DioException) {
        if (e.response != null && e.response?.data != null) {
          // FIX: Properly handle the response data
          if (e.response!.data is Map<String, dynamic>) {
            errorMessage = e.response!.data['message'] ?? errorMessage;
          } else if (e.response!.data is String) {
            errorMessage = e.response!.data;
          }
        } else {
          errorMessage = e.message ?? errorMessage;
        }
      } else {
        errorMessage = e.toString();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(errorMessage)),
      );
      return false;
    }
  }
}
