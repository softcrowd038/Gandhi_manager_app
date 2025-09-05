import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/get_finance_letter_model.dart';
import 'package:gandhi_tvs/services/verify_finance_letter.dart';

class GetFinanceLetterProvider extends ChangeNotifier {
  GetFinanceLetterModel? _getFinanceLetterModel;
  String? _errorMessage;
  bool _isLoading = false;

  GetFinanceLetterModel? get getFinanceLetterModel => _getFinanceLetterModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> fetchFinanceLetters(
    BuildContext context,
    String? bookingId,
  ) async {
    _isLoading = true;
    notifyListeners();

    final service = GetFinanceLetterService();
    final models = await service.getFinanceLetterService(context, bookingId);

    if (models != null) {
      _getFinanceLetterModel = models;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Kyc Documents.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
