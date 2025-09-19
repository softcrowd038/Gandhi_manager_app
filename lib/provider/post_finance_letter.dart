// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/finance_letter_model.dart';

class FinanceLetterProvider extends ChangeNotifier {
  bool _isLoading = false;
  FinanceLetterModel _financeLetterModel = FinanceLetterModel();
  Map<String, dynamic>? _kycResponse;

  bool get isLoading => _isLoading;
  FinanceLetterModel get financeLetterModel => _financeLetterModel;
  Map<String, dynamic>? get kycResponse => _kycResponse;

  void updateFinanceLetterModel(FinanceLetterModel model) {
    _financeLetterModel = model;
    notifyListeners();
  }

  Future<void> postKYC(
    BuildContext context,
    FinanceLetterModel financeLetterModel,
    String? bookingId,
    bool isIndexThree,
  ) async {
    _isLoading = true;
    notifyListeners();

    final kycService = PostFinanceService();
    final response = await kycService.postFinanceLetterModel(
      context,
      financeLetterModel,
      bookingId,
      isIndexThree,
    );

    _isLoading = false;

    if (response != null) {
      _kycResponse = response;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Finance Letter posted successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to post Finance Letter"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }

    notifyListeners();
  }

  void resetFinanceLetterModel() {
    _financeLetterModel = FinanceLetterModel();
    notifyListeners();
  }

  void setFinanceLetter(String value) {
    _financeLetterModel.financeLetter = value;
    notifyListeners();
  }
}
