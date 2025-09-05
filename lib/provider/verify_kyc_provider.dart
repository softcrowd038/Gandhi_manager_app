import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/get_kyc_model.dart';
import 'package:gandhi_tvs/services/verify_kyc_service.dart';

class VerifyKycProvider extends ChangeNotifier {
  GetKycModel? _getKycModel;
  String? _errorMessage;
  bool _isLoading = false;

  GetKycModel? get kycModel => _getKycModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> fetchKycDocuments(
    BuildContext context,
    String? bookingId,
  ) async {
    _isLoading = true;
    notifyListeners();

    final service = GetKycService();
    final models = await service.getKycService(context, bookingId);

    if (models != null) {
      _getKycModel = models;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Kyc Documents.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
