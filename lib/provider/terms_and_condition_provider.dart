import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/terms_and_condition_model.dart';

class TermsAndConditionProvider with ChangeNotifier {
  TermsAndConditionModel? _termsAndConditionModel;
  bool _isLoading = false;
  String? _errorMessage;

  TermsAndConditionModel? get termsAndConditionModel => _termsAndConditionModel;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchTermsAndConditions(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = TermsAndConditionService();
    final terms = await service.getAllTermsAndConditions(context);

    if (terms != null) {
      _termsAndConditionModel = terms;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch T&C.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
