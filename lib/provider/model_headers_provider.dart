import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/model_headers.dart';

class ModelHeadersProvider extends ChangeNotifier {
  ModelHeaders? _modelHeaders;
  String? _errorMessage;
  bool _isLoading = false;

  ModelHeaders? get modelHeaders => _modelHeaders;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> fetchModelHeaders(BuildContext context, String? modelId) async {
    _isLoading = true;
    notifyListeners();

    final service = ModelHeadersService();
    final models = await service.getModelHeaders(context, modelId);

    if (models != null) {
      _modelHeaders = models;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Model Headers.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
