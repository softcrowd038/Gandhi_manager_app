import 'package:gandhi_tvs/common/app_imports.dart';

class GenerateQuotationProvider with ChangeNotifier {
  final QuotationService _quotationService = QuotationService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _financeNeeded = false;
  bool get financeNeeded => _financeNeeded;

  Map<String, dynamic>? _rawResponse;
  Map<String, dynamic>? get rawResponse => _rawResponse;

  void toggleFinanceNeeded(bool value) {
    _financeNeeded = value;
    notifyListeners();
  }

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> generateQuotation(
    GenerateQuotation quotationRequest,
    BuildContext context,
  ) async {
    isLoading = true;
    _errorMessage = '';

    _rawResponse = null;

    try {
      final response = await _quotationService.generateQuotation(
        quotationRequest,
      );

      isLoading = false;

      if (response['status'] == 'error') {
        _errorMessage = response['message'] ?? 'Unknown error';
        notifyListeners();
        return false;
      }

      notifyListeners();
      return true;
    } catch (error) {
      isLoading = false;
      _errorMessage = 'Unexpected error: $error';
      notifyListeners();
      return false;
    }
  }
}
