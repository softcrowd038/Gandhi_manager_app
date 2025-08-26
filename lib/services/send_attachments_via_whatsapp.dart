import 'package:gandhi_tvs/common/app_imports.dart';

class WhatsAppApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: whatsAppBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  Future<Map<String, dynamic>> sendWhatsAppMessage({
    required String apiKey,
    required String mobile,
    required String message,
    required String pdfUrl,
    required List<String> imageUrls,
    required String? video,
    required String youtube,
  }) async {
    try {
      final formData = FormData.fromMap({
        'apikey': apiKey,
        'mobile': mobile,
        'msg': '$message.  watch now:  $youtube',
        'pdf': '$baseImageUrl/public$pdfUrl',
        if (imageUrls.isNotEmpty) 'img1': imageUrls[0],
        if (imageUrls.length > 1) 'img2': imageUrls[1],
        if (imageUrls.length > 2) 'img3': imageUrls[2],
        if (imageUrls.length > 3) 'img4': imageUrls[3],
        'video': video == "" ? "" : '$baseImageUrl/public$video',
      });

      final response = await _dio.post('/wapp/v2/api/send', data: formData);

      return _parseResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Unexpected error: ${e.toString()}',
      };
    }
  }

  Map<String, dynamic> _parseResponse(Response response) {
    try {
      if (response.data is Map) {
        return response.data as Map<String, dynamic>;
      }
      return {
        'status': response.statusCode == 200 ? 'success' : 'error',
        'message': response.data.toString(),
        'statusCode': response.statusCode,
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Response parsing failed: ${e.toString()}',
        'rawResponse': response.data.toString(),
      };
    }
  }

  Map<String, dynamic> _handleDioError(DioException e) {
    final statusCode = e.response?.statusCode;
    final errorData = e.response?.data?.toString() ?? 'No response data';

    if (statusCode == 404) {
      return {
        'status': 'error',
        'message': 'API endpoint not found. Please verify the URL.',
        'errorType': 'not_found',
        'statusCode': 404,
        'suggestion': 'Contact API provider for correct endpoint',
      };
    }

    return {
      'status': 'error',
      'message': 'Server error: $statusCode - $errorData',
      'errorType': e.type.name,
      'statusCode': statusCode,
    };
  }
}
