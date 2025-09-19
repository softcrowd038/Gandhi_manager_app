// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';

class GetHelmetDeclarationService {
  Future<Dio> getDioInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        headers: {
          'Accept': 'application/pdf',
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }

  Future<Uint8List?> getDeclarations(
    BuildContext context,
    String chassisNumber,
  ) async {
    try {
      final dio = await getDioInstance();
      final response = await dio.get(
        "bookings/helmet-declaration/$chassisNumber",
        options: Options(
          responseType: ResponseType.bytes, // 👈 return raw bytes
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        return Uint8List.fromList(response.data);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to fetch Declaration')),
        );
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

      debugPrint('Error: $errorMessage');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
      return null;
    }
  }
}
