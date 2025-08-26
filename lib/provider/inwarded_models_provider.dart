import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/inward_model_details.dart';

class InwardedModelsProvider extends ChangeNotifier {
  InwardModelDetails? _inwardModelDetails;
  String? _errorMessage;
  bool? _isLoading = false;

  InwardModelDetails? get inwardModelDetails => _inwardModelDetails;
  String? get errorMessage => _errorMessage;
  bool? get isLoading => _isLoading;

  Future<void> getInwardedModelProvider(
    BuildContext context,
    String branchId,
  ) async {
    _isLoading = true;
    notifyListeners();

    final service = InwardedVehicleService();

    final models = await service.getInwardedModels(context, branchId);

    if (models != null) {
      _inwardModelDetails = models;
      debugPrint(
        _inwardModelDetails?.data?.vehicles
            .map((booking) {
              return booking.chassisNumber;
            })
            .toList()
            .toString(),
      );
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch bike models.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
