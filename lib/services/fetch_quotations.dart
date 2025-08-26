// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_quotations_model.dart';

class AllQuotationService {
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

  Future<AllQuotationModel> fetchQuotation(BuildContext context) async {
    try {
      final dio = await getDioInstance();
      final response = await dio.get('quotations');

      if (response.statusCode == 200) {
        return AllQuotationModel.fromJson(response.data);
      } else {
        // handleErrorResponse(response.statusCode, context);
        throw Exception('Failed to load quotations');
      }
    } on DioError catch (e) {
      // handleErrorResponse(e.response?.statusCode, context);
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
