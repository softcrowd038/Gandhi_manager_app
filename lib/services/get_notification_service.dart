// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/get_notification_model.dart';

class GetNotificationSerice {
  Future<Dio> getDioInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

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

  Future<GetNotificationMOdel?> getNotifications(BuildContext context) async {
    try {
      final dio = await getDioInstance();

      final response = await dio.get("bookings/pending");

      if (response.statusCode == 200) {
        print(response.data);
        return GetNotificationMOdel.fromJson(response.data);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to fetch Notification')));
      }
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

      debugPrint('notification Error: $errorMessage');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
      return null;
    }
  }
}
