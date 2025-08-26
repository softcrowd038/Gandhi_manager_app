import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/scanned_model_details.dart';

class GetInwardModelDetailsQr extends ChangeNotifier {
  ScannedModelDetails? _inwardModelDetails;
  String? _errorMessage;
  bool? _isLoading;

  ScannedModelDetails? get inwardModelDetails => _inwardModelDetails;
  String? get errorMessage => _errorMessage;
  bool? get isLoading => _isLoading;

  Future<void> fetchInwardBikeDetails(
    BuildContext context,
    String? qrCode,
  ) async {
    _isLoading = true;
    notifyListeners();

    final service = GetInwardDetailsByQrcode();
    final inwardModels = await service.getInwardModelDetails(context, qrCode);

    if (inwardModels != null) {
      _inwardModelDetails = inwardModels;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch inward bike models.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
