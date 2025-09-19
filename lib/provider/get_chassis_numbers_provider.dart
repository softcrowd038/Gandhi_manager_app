import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/get_chassis_numbers.dart';

class GetChassisNumbersProvider with ChangeNotifier {
  GetChassisNumberModel? _chassisNumberModel;
  bool _isLoading = false;
  String? _errorMessage;

  GetChassisNumberModel? get chassisNumberModel => _chassisNumberModel;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchChassisNumbers(
    BuildContext context,
    String modelId,
    String colorId,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    // Don't notify here to avoid build conflicts

    final service = GetChassisNumbersService();
    final models = await service.getChassisNumber(context, modelId, colorId);

    if (models != null) {
      _chassisNumberModel = models;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Chassis Numbers.';
    }

    _isLoading = false;
    notifyListeners(); // Only notify once at the end
  }

  // Clear previous data when fetching new data
  void clearData() {
    _chassisNumberModel = null;
    _errorMessage = null;
    notifyListeners();
  }
}
