import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getUserBranch() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  return sharedPreferences.getString('branch');
}
