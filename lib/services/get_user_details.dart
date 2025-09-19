// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/user_details.dart';

class GetUserDetails {
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

  Future<UserDetails?> getUserDetails(BuildContext context) async {
    try {
      String token = await getAuthToken();
      if (token.isEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const UserLogin()),
          );
        });
        return null;
      }

      SharedPreferences prefs = await SharedPreferences.getInstance();
      Dio dio = await getDioInstance();

      if (dio.options.headers['Authorization'] == 'Bearer ') {
        return null;
      }

      final response = await dio.get('/auth/me');
      handleErrorResponse(response.statusCode, context);

      prefs.setString('branch', response.data['data']['branch']);

      if (response.data['data']['roles'] != null &&
          (response.data['data']['roles'] as List).isNotEmpty) {
        final roles = response.data['data']['roles'] as List;

        // Take the first role
        final firstRole = roles.first;

        final String roleId = firstRole['_id'] ?? '';
        final String roleName = firstRole['name'] ?? '';

        if (roleId.isNotEmpty) {
          prefs.setString('role_id', roleId);
        }
        if (roleName.isNotEmpty) {
          prefs.setString('role_name', roleName);
        }
      }

      return UserDetails.fromJson(response.data);
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
                  "Failed to fetch user details",
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

      debugPrint('debug Error: $errorMessage');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
      return null;
    }
  }
}
