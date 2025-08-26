import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/colors_models.dart';

class ColorsProvider extends ChangeNotifier {
  ColorsModel? _colorsModel;
  bool? _isLoading;
  String? _errorMessage;

  ColorsModel? get colorModels => _colorsModel;
  bool get isLoading => _isLoading!;
  String? get errorMessage => _errorMessage;

  Future<void> fetchBikeModelsColor(
    BuildContext context,
    String modelId,
  ) async {
    _isLoading = true;
    notifyListeners();

    final service = ColorsService();
    final models = await service.getAllBikeModelsColors(context, modelId);

    if (models != null) {
      _colorsModel = models;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch bike models.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
