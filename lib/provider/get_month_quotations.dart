// ignore_for_file: file_names

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/quotations_by_month.dart';

class GetMonthQuotations extends ChangeNotifier {
  final FetchQuotationsByMonth _quotationService = FetchQuotationsByMonth();

  bool _isLoading = false;
  String? _errorMessage;
  QuotationsByMonth? _quotation;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  QuotationsByMonth? get quotation => _quotation;

  Future<void> fetchMonthStatsofQuotations(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _quotationService.fetchQuotationsByMonth(context);
      _quotation = result;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
