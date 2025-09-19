// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';

class BrokerOtpVerifyProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _apiResponse;
  bool _onClicked = false;

  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  Map<String, dynamic>? get apiResponse => _apiResponse;
  bool get onClicked => _onClicked;

  Future<void> postOtpBrokerVerification(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final brokerOTPService = BrokerOTPService();
      _apiResponse = await brokerOTPService.sendBrokerOtp(context);

      if (_apiResponse != null) {
        final status = _apiResponse?['success'] ?? false;
        final message = _apiResponse?['message'] ?? 'Unknown error occurred';

        if (status) {
          _onClicked = true;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.green),
          );
        } else {
          _errorMessage = message;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
          );
        }
      } else {
        _errorMessage = 'Something went wrong, please try again.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage!),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      _errorMessage = 'Error: ${e.toString()}';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _apiResponse = null;
    _onClicked = false;
    notifyListeners();
  }
}
