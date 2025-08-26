import 'package:gandhi_tvs/common/app_imports.dart';

class BikeModelProvider with ChangeNotifier {
  BikeModels? _bikeModels;
  bool _isLoading = false;
  String? _errorMessage;

  BikeModels? get bikeModels => _bikeModels;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchBikeModels(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = BikeModelService();
    final models = await service.getAllBikeModels(context);

    if (models != null) {
      _bikeModels = models;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch bike models.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
