// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';

class UpdateBookingService {
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

  Future<Map<String, dynamic>?> updateBooking(
    BuildContext context,
    String? id,
    BookingFormModel? bookingFormModel,
  ) async {
    print(id);
    print("entered");

    try {
      final dio = await getDioInstance();

      final data = bookingFormModel?.toJson();

      final response = await dio.put('bookings/$id', data: data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigationPage(index: 3)),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Booking updated successfully")),
        );
        return response.data; // Return response data
      } else {
        print(response.statusCode);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to update booking: ${response.statusCode}"),
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
