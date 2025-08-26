// ignore_for_file: use_build_context_synchronously
import 'package:gandhi_tvs/common/app_imports.dart';

class UserLoginProvider with ChangeNotifier {
  String _mobile = '';
  bool _isLoading = false;
  Map<String, dynamic>? _loginResponse;

  String get mobile => _mobile;
  bool get isLoading => _isLoading;
  Map<String, dynamic>? get loginResponse => _loginResponse;

  void setMobile(String value) {
    _mobile = value;
    notifyListeners();
  }

  Future<void> login(String mobileNumber, BuildContext context) async {
    if (mobileNumber.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mobile cannot be empty'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    _isLoading = true;
    notifyListeners();

    final userLoginService = UserLoginService();
    _loginResponse = await userLoginService.login(mobileNumber, context);

    _isLoading = false;
    notifyListeners();

    if (_loginResponse != null) {
      final status = _loginResponse?['success'];
      final message = _loginResponse?['message'] ?? 'Unknown error occurred';

      if (status == false) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
        );
      } else {
        _mobile = mobileNumber;
        notifyListeners();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.green),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong, please try again.'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }
}
