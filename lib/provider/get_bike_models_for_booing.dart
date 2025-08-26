import 'package:gandhi_tvs/common/app_imports.dart';

class BookingBikeModelProvider with ChangeNotifier {
  BikeModels? _bikeModels;
  bool _isLoading = false;
  String? _errorMessage;

  BikeModels? get bikeModels => _bikeModels;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchBikeModels(
    BuildContext context,
    String? customerType,
  ) async {
    _isLoading = true;
    notifyListeners();

    final service = BookingBikeModelService();
    final models = await service.getAllBookingBikeModels(context, customerType);

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
