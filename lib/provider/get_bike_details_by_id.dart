import 'package:gandhi_tvs/common/app_imports.dart';

class GetBikeDetailsByIdProvider extends ChangeNotifier {
  BikeModels? _bikeModels;
  String? _errormessage;
  bool? _isLoading;

  BikeModels? get bikeModels => _bikeModels;
  String? get errorMessage => _errormessage;
  bool? get isLoading => _isLoading;

  Future<void> fetchBikeModels(BuildContext context, String modelId) async {
    _isLoading = true;
    notifyListeners();
    final service = GetBikeModelsById();
    final models = await service.getBikeModelsById(context, modelId);

    if (models != null) {
      _bikeModels = models;
      _errormessage = null;
    } else {
      _errormessage = 'Failed to fetch Exchange Brokers.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
