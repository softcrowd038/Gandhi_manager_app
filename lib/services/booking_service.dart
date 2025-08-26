// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';

class BookingService {
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

  Future<Map<String, dynamic>?> postBookingFormModel(
    BuildContext context,
    BookingFormModel bookingFormModel,
  ) async {
    try {
      final dio = await getDioInstance();

      final response = await dio.post(
        'bookings',
        data: bookingFormModel.toJson(),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigationPage(index: 3)),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Booking posted successfully")),
        );
        return response.data;
      } else {
        print(response.statusCode);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to post booking: ${response.statusCode}"),
          ),
        );
        return null;
      }
    } catch (e) {
      String errorMessage = "Something went wrong";
      print(e);

      if (e is DioException) {
        if (e.response != null && e.response?.data != null) {
          errorMessage = e.response?.data['message'] ?? errorMessage;
        } else {
          errorMessage = e.message ?? "";
        }
      } else {
        errorMessage = e.toString();
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $errorMessage")));

      return null;
    }
  }
}
