import 'package:gandhi_tvs/common/app_imports.dart';

void setKYCField(KYCProvider kycProvider, int index, String value) {
  switch (documents[index].toLowerCase()) {
    case "aadhar front":
      kycProvider.setAadharFront(value);

      break;
    case "aadhar back":
      kycProvider.setAadharBack(value);

      break;
    case "pan card":
      kycProvider.setPanCard(value);

      break;
    case "vehicle photo":
      kycProvider.setVPhoto(value);

      break;
    case "chassis no photo":
      kycProvider.setChasisNoPhoto(value);

      break;
    case "address proof 1":
      kycProvider.setAddressProof1(value);

      break;
    case "address proof 2":
      kycProvider.setAddressProof2(value);

      break;
    default:
      break;
  }
}
