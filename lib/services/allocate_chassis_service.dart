// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:gandhi_tvs/common/app_imports.dart';

class AllocateChassisService {
  Future<Dio> getDioInstance() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');

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

  Future<Map<String, dynamic>?> allocateChassis(
    BuildContext context,
    String? id,
    ChassisAllocationModel chassisAllocateModel,
  ) async {
    print('=== CHASSIS ALLOCATION SERVICE ===');
    print('Booking ID: $id');
    print('Chassis Number: ${chassisAllocateModel.chassisNumber}');
    print('Reason: ${chassisAllocateModel.reason}');
    print('Has Claim: ${chassisAllocateModel.hasClaim}');
    print('Has Claim: ${chassisAllocateModel.hasDeviation}');
    print('Price Claim: ${chassisAllocateModel.priceClaim}');
    print('Description: ${chassisAllocateModel.description}');
    print('Documents: ${chassisAllocateModel.documents.length}');

    try {
      final dio = await getDioInstance();

      final requestData = {
        'chassisNumber': chassisAllocateModel.chassisNumber,
        'hasClaim': chassisAllocateModel.hasClaim.toString(),
        'is_deviation': chassisAllocateModel.hasDeviation == true
            ? 'YES'
            : "NO",
        if (chassisAllocateModel.priceClaim != null)
          'priceClaim': chassisAllocateModel.priceClaim!.toString(),
        if (chassisAllocateModel.description != null &&
            chassisAllocateModel.description!.isNotEmpty)
          'description': chassisAllocateModel.description,
      };

      final encodedReason = Uri.encodeComponent(
        chassisAllocateModel.reason ?? "",
      );
      final url = 'bookings/$id/allocate?reason=$encodedReason';

      FormData? formData;
      Options? options;

      if (chassisAllocateModel.hasClaim &&
          chassisAllocateModel.documents.isNotEmpty) {
        // Use FormData for file uploads
        formData = FormData.fromMap(requestData);

        // Add document files
        for (int i = 0; i < chassisAllocateModel.documents.length; i++) {
          final file = chassisAllocateModel.documents[i];
          formData.files.add(
            MapEntry(
              'documents', // Field name expected by backend
              await MultipartFile.fromFile(file.path, filename: file.name),
            ),
          );
        }

        options = Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'Accept': 'application/json',
          },
        );
      } else {
        // Use JSON for regular requests
        options = Options(headers: {'Content-Type': 'application/json'});
      }

      print('Request URL: $url');
      print('Request Data: $requestData');
      print('Using FormData: ${formData != null}');

      final response = await dio.put(
        url,
        data: formData ?? requestData,
        options: options,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('✅ Success Response: ${response.data}');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Chassis allocated successfully"),
            backgroundColor: Colors.green,
          ),
        );

        return response.data;
      } else {
        print('❌ Failed with status: ${response.statusCode}');
        print('❌ Response data: ${response.data}');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to allocate chassis: ${response.statusCode}"),
            backgroundColor: Colors.red,
          ),
        );
        return null;
      }
    } on DioException catch (e) {
      print('🔥 DioException Details:');
      print('🔥 Error: ${e.error}');
      print('🔥 Message: ${e.message}');
      print('🔥 Response: ${e.response?.data}');
      print('🔥 Status Code: ${e.response?.statusCode}');
      print('🔥 Headers: ${e.response?.headers}');

      String errorMessage = "Failed to allocate chassis";

      if (e.response != null) {
        final responseData = e.response!.data;
        if (responseData is Map) {
          errorMessage =
              responseData['message'] ??
              responseData['error'] ??
              'Server error: ${e.response!.statusCode}';

          // Check for validation errors
          if (responseData['errors'] is Map) {
            final errors = responseData['errors'] as Map;
            errorMessage +=
                '\nValidation errors: ${errors.entries.map((e) => '${e.key}: ${e.value}').join(', ')}';
          }
        } else if (responseData is String) {
          errorMessage = responseData;
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );

      return null;
    } catch (e) {
      print('💥 Unexpected error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Unexpected error: $e"),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    }
  }

  // Helper method for testing
  Future<void> testAllocation(
    BuildContext context,
    String bookingId,
    String chassisNumber,
    String reason, {
    bool hasClaim = false,
    double? priceClaim,
    String? description,
    List<XFile> documents = const [],
  }) async {
    final testModel = ChassisAllocationModel(
      chassisNumber: chassisNumber,
      reason: reason,
      hasClaim: hasClaim,
      priceClaim: priceClaim,
      description: description,
      documents: documents,
    );

    final result = await allocateChassis(context, bookingId, testModel);
    print('Test result: $result');
  }
}
