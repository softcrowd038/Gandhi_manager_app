// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/quotation_model.dart';

class QuotationServiceByID {
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

  Future<QuotationResponse> fetchQuotationById(
    String? quotationId,
    BuildContext context,
  ) async {
    try {
      final dio = await getDioInstance();
      final response = await dio.get('quotations/byId/$quotationId');

      if (response.statusCode == 200) {
        return QuotationResponse.fromJson(response.data);
      } else {
        throw Exception('Failed to load quotation');
      }
    } on DioError catch (e) {
      throw Exception('Error: ${e.message}');
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
      throw Exception('Error: $errorMessage');
    }
  }
}
