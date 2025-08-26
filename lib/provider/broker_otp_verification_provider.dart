// ignore_for_file: use_build_context_synchronously
import 'package:gandhi_tvs/common/app_imports.dart';

class BrokerOtpVerificationProvider with ChangeNotifier {
  bool _isLoading = false;
  Map<String, dynamic>? _otpResponse;
  bool _isVerified = false;
  bool _onClicked = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  Map<String, dynamic>? get otpResponse => _otpResponse;
  bool get isVerified => _isVerified;
  bool get onClicked => _onClicked;
  String? get errorMessage => _errorMessage;

  Future<bool> verifyOtp(String otp, BuildContext context) async {
    if (otp.trim().isEmpty) {
      _errorMessage = "OTP cannot be empty";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final otpVerificationService = BrokerOtpVerification();
      _otpResponse = await otpVerificationService.verifyOTP(otp, context);

      final success = _otpResponse?['success'] ?? false;
      final message = _otpResponse?['message'] ?? 'Unknown error occurred';

      if (success) {
        _isVerified = true;
        return true;
      } else {
        _errorMessage = message;
        _isVerified = false;
        return false;
      }
    } catch (e) {
      _errorMessage = 'Error: ${e.toString()}';
      _isVerified = false;
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _isLoading = false;
    _otpResponse = null;
    _onClicked = false;
    _errorMessage = null;
    notifyListeners();
  }
}
