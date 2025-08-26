import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_quotations_model.dart';

class AllQuotationProvider with ChangeNotifier {
  final AllQuotationService _service = AllQuotationService();

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
      final result = await _service.fetchQuotation(context);
      _quotation = result;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
