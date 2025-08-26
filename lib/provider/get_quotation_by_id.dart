// ignore_for_file: file_names

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/quotation_model.dart';

class QuotationProvider extends ChangeNotifier {
  final QuotationServiceByID _quotationService = QuotationServiceByID();

  bool _isLoading = false;
  String? _errorMessage;
  QuotationResponse? _quotation;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  QuotationResponse? get quotation => _quotation;

  Future<void> fetchQuotationById(String? id, BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _quotationService.fetchQuotationById(id, context);
      _quotation = result;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
