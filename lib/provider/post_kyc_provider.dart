// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/kyc_model.dart';

class KYCProvider extends ChangeNotifier {
  bool _isLoading = false;
  KYCModel _kycModel = KYCModel();
  Map<String, dynamic>? _kycResponse;

  bool get isLoading => _isLoading;
  KYCModel get kycModel => _kycModel;
  Map<String, dynamic>? get kycResponse => _kycResponse;

  void updateKYCModel(KYCModel model) {
    _kycModel = model;
    notifyListeners();
  }

  Future<void> postKYC(
    BuildContext context,
    KYCModel kycModel,
    String? bookingId,
    bool isIndexThree,
  ) async {
    _isLoading = true;
    notifyListeners();

    final kycService = PostKycService();
    final response = await kycService.postKYCDocumentModel(
      context,
      kycModel,
      bookingId,
      isIndexThree,
    );

    _isLoading = false;

    if (response != null) {
      _kycResponse = response;
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("KYC posted successfully"),
            backgroundColor: Colors.green,
          ),
        );
      }
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to post KYC"),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }

    notifyListeners();
  }

  void resetKYCModel() {
    _kycModel = KYCModel();
    notifyListeners();
  }

  void setAadharFront(String value) {
    _kycModel.aadharFront = value;
    notifyListeners();
  }

  void setAadharBack(String value) {
    _kycModel.aadharBack = value;
    notifyListeners();
  }

  void setPanCard(String value) {
    _kycModel.panCard = value;
    notifyListeners();
  }

  void setVPhoto(String value) {
    _kycModel.vPhoto = value;
    notifyListeners();
  }

  void setChasisNoPhoto(String value) {
    _kycModel.chasisNoPhoto = value;
    notifyListeners();
  }

  void setAddressProof1(String value) {
    _kycModel.addressProof1 = value;
    notifyListeners();
  }

  void setAddressProof2(String value) {
    _kycModel.addressProof2 = value;
    notifyListeners();
  }
}
