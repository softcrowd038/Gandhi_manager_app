import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/financer_model.dart';

class FinancerProvider extends ChangeNotifier {
  FinancerModel? _financerModel;
  String? _errorMessage;
  bool _isLoading = false;

  FinancerModel? get financeModel => _financerModel;
  String? get errorMessage => _errorMessage;
  bool? get isLoading => _isLoading;

  Future<void> fetchFinancers(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = FinancerService();
    final financers = await service.getFinancerDetails(context);

    if (financers != null) {
      _financerModel = financers;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Financers.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
