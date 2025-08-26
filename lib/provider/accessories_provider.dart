import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/accessories_model.dart';

class AccessoriesProvider extends ChangeNotifier {
  AccessoriesModel? _accessoriesModel;
  String? _errorMessage;
  bool _isLoading = false;

  AccessoriesModel? get accessoriesModel => _accessoriesModel;
  String? get errorMessage => _errorMessage;
  bool? get isLoading => _isLoading;

  Future<void> getAllAccessoriesByModel(
    BuildContext context,
    String? modelId,
  ) async {
    _isLoading = true;
    notifyListeners();

    final service = AccessoriesService();
    final accessories = await service.getAccessories(context, modelId);

    if (accessories != null) {
      _accessoriesModel = accessories;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Accessories.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
