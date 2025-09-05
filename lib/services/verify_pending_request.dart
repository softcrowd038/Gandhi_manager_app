import 'package:gandhi_tvs/common/app_imports.dart';

class VerifyPendingRequest {
  Future<Dio> getDioInstance() async {
    String token = await getAuthToken();

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

  Future<Map<String, dynamic>?> approvePendingRequests(
    BuildContext context,
    String? bookingId,
    String? status,
  ) async {
    try {
      Dio dio = await getDioInstance();

      final response = await dio.post(
        'bookings/$bookingId/${status == "APPROVED" ? "approve-update" : "reject-update"}',
      );
      print(response.statusCode);
      handleErrorResponse(response.statusCode, context);

      return response.data;
    } on DioException catch (dioError) {
      debugPrint('DioError: ${dioError.message}');
      if (dioError.response != null) {
        debugPrint('Response: ${dioError.response?.data}');

        if (dioError.response?.statusCode == 401) {
          handleErrorResponse(401, context);
          return null;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              dioError.response?.data['message'] ??
                  "Failed to fetch Kyc Documents",
            ),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(dioError.message ?? ""),
            backgroundColor: Colors.red,
          ),
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
