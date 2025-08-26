// ignore_for_file: file_names

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/quotations_by_day.dart';

class GetTodayQuotations extends ChangeNotifier {
  final FetchQuotationsByDay _quotationService = FetchQuotationsByDay();

  bool _isLoading = false;
  String? _errorMessage;
  QuotationsByDay? _quotation;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  QuotationsByDay? get quotation => _quotation;

  Future<void> fetchDayStatsofQuotations(BuildContext context) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await _quotationService.fetchQuotationsByDay(context);
      _quotation = result;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
