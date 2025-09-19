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

  Future<AllQuotationModel> fetchQuotations(BuildContext context) async {
    try {
      final dio = await getDioInstance();
      final response = await dio.get('quotations');
    

      if (response.statusCode == 200) {
      
        return AllQuotationModel.fromJson(response.data);
      } else {
        _handleErrorResponse(response.statusCode, context);
        throw Exception(
          'Failed to load quotations: Status code ${response.statusCode}',
        );
      }
    } catch (e) {
      _handleGenericError(e, context);
      throw Exception('Unexpected error: $e');
    }
  }

  void _handleErrorResponse(int? statusCode, BuildContext context) {
    String errorMessage = "Failed to load quotations";

    switch (statusCode) {
      case 401:
        errorMessage = "Unauthorized access. Please login again.";
        break;
      case 403:
        errorMessage = "Access forbidden";
        break;
      case 404:
        errorMessage = "Quotations not found";
        break;
      case 500:
        errorMessage = "Server error. Please try again later.";
        break;
      default:
        errorMessage = "Failed to load quotations (Error: $statusCode)";
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _handleGenericError(dynamic e, BuildContext context) {
    String errorMessage = "Something went wrong";

    if (e is String) {
      errorMessage = e;
    } else if (e is Exception) {
      errorMessage = e.toString();
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(errorMessage),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
