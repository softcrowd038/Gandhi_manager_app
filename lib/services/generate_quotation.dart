// ignore_for_file: deprecated_member_use

import 'package:gandhi_tvs/common/app_imports.dart';

class QuotationService {
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

  Future<Map<String, dynamic>> generateQuotation(
    GenerateQuotation quotation,
  ) async {
    try {
      final response = await getDioInstance();

      final responseData = await response.post(
        'quotations',
        data: quotation.toJson(),
      );

      if (responseData.statusCode == 200 &&
          responseData.data['status'] != 'error') {
        return responseData.data;
      }

      return responseData.data;
    } on DioError catch (dioError) {
      if (dioError.response != null && dioError.response?.data != null) {
        return dioError.response?.data;
      } else {
        return {
          'status': 'error',
          'message': 'Network error occurred. Please try again.',
        };
      }
    } catch (error) {
      return {'status': 'error', 'message': 'Unexpected error: $error'};
    }
  }
}
