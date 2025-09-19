// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/finance_letter_model.dart';

class PostFinanceService {
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

  Future<Map<String, dynamic>?> postFinanceLetterModel(
    BuildContext context,
    FinanceLetterModel financeLetterModel,
    String? bookingId,
    bool isIndexThree,
  ) async {
    print(isIndexThree);
    try {
      final dio = await getDioInstance();

      if (bookingId == null || bookingId.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Booking ID is missing")));
        return null;
      }

      final formData = await financeLetterModel.toFormData();

      final response = await dio.post(
        'finance-letters/$bookingId/submit',
        data: formData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => NavigationPage(index: isIndexThree ? 3 : 4),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Finance Letter posted successfully")),
        );
        return response.data;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Failed to post Finance Letter: ${response.statusCode}",
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $errorMessage")));

      return null;
    }
  }
}
