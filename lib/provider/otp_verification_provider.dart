// ignore_for_file: use_build_context_synchronously
import 'package:gandhi_tvs/common/app_imports.dart';

class OtpVerificationProvider with ChangeNotifier {
  bool _isLoading = false;
  Map<String, dynamic>? _otpResponse;

  bool get isLoading => _isLoading;
  Map<String, dynamic>? get otpResponse => _otpResponse;

  Future<void> verifyOtp(String otp, BuildContext context) async {
    if (otp.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP cannot be empty'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    _isLoading = true;
    notifyListeners();
    final otpVerificationService = OtpVerificationService();
    _otpResponse = await otpVerificationService.verifyOTP(otp, context);

    _isLoading = false;
    notifyListeners();

    final success = _otpResponse?['success'];

    final message = _otpResponse?['message'] ?? 'Unknown error occurred';

    if (success == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Logged In Successfully'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }
}
