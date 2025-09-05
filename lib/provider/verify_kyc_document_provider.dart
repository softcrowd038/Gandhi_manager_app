import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/services/verify_kyc_documents_service.dart';

class VerifyKycDocumentProvider extends ChangeNotifier {
  bool _isLoading = false;
  Map<String, dynamic>? _updateResponse;

  bool get isLoading => _isLoading;
  Map<String, dynamic>? get updateResponse => _updateResponse;

  Future<void> verifyKyc(
    BuildContext context,
    String? id,
    String? status,
  ) async {
    _isLoading = true;
    notifyListeners();

    final updateBookingService = VerifyKycDocumentsService();
    final response = await updateBookingService.verifyKycDocumentsService(
      context,
      id,
      status,
    );

    _isLoading = false;

    if (response != null) {
      _updateResponse = response;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Kyc Verified successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to Verify KYC"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }

    notifyListeners();
  }

  void reset() {
    _isLoading = false;
    _updateResponse = null;
    notifyListeners();
  }
}
