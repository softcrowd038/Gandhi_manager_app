// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';

Future<String> getAuthToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  return token ?? '';
}

Future<void> removeAuthToken(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
  await prefs.remove('user_id');
  await prefs.remove('role');
  await prefs.remove('role_name');
  await prefs.remove('role_id');
  await prefs.remove('branch');

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => const UserLogin()),
  );
}

void handleErrorResponse(int? statusCode, BuildContext context) {
  if (statusCode == 401 ||
      statusCode == 404 ||
      statusCode == 500 ||
      statusCode == 502 ||
      statusCode == 403) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      removeAuthToken(context);
    });
  }
}
