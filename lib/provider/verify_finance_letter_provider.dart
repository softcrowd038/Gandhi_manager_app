// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';

class VerifyFinanceLetterProvider extends ChangeNotifier {
  bool _isLoading = false;
  Map<String, dynamic>? _updateResponse;

  bool get isLoading => _isLoading;
  Map<String, dynamic>? get updateResponse => _updateResponse;

  Future<void> verifyFinanceLetter(
    BuildContext context,
    String? id,
    String? status,
    bool isIndexThree,
  ) async {
    _isLoading = true;
    notifyListeners();

    final updateBookingService = VerifyFinanceDocumentsService();
    final response = await updateBookingService.verifyFinanceDocumentsService(
      context,
      id,
      status,
      isIndexThree,
    );

    _isLoading = false;

    if (response != null) {
      _updateResponse = response;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Finance Letter Verified successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to Verify Finance letter"),
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
