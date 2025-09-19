import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_quotations_model.dart';

class AllQuotationProvider with ChangeNotifier {
  AllQuotationModel? _quotation;
  bool _isLoading = false;
  String? _errorMessage;

  AllQuotationModel? get quotation => _quotation;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchQuotations(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final service = AllQuotationService();
      final result = await service.fetchQuotations(context);

      _quotation = result;
      _errorMessage = null;

      if (result.data.quotations.isNotEmpty) {
      } else {}
    } catch (e) {
      _errorMessage = e.toString();

      if (e.toString().contains('Network error:')) {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      } else if (e.toString().contains('Failed to load quotations:')) {
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<void> refresh(BuildContext context) async {
    await fetchQuotations(context);
  }
}
