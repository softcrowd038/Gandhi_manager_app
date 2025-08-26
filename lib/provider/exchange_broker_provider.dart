import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/exchange_broker_model.dart';

class ExchangeBrokerProvider extends ChangeNotifier {
  ExchangeBrokerModel? _exchangeBrokerModel;
  bool _isLoading = false;
  String? _errorMessage;

  ExchangeBrokerModel? get exchangeBrokerModel => _exchangeBrokerModel;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchExchangeBroker(
    BuildContext context,
    String branchID,
  ) async {
    _isLoading = true;
    notifyListeners();

    final service = ExchangeBrokerService();
    final models = await service.getAllExchangeBrokers(context, branchID);

    if (models != null) {
      _exchangeBrokerModel = models;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Exchange Brokers.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
