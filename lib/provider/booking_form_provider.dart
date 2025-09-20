// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';

class BookingFormProvider extends ChangeNotifier {
  bool _isLoading = false;
  BookingFormModel _bookingFormModel = BookingFormModel();
  Map<String, dynamic>? _bookingResponse;

  bool get isLoading => _isLoading;
  BookingFormModel get bookingFormModel => _bookingFormModel;
  Map<String, dynamic>? get bookingResponse => _bookingResponse;

  void updateBookingFormModel(BookingFormModel model) {
    _bookingFormModel = model;
    notifyListeners();
  }

  Future<void> postBookingForm(
    BuildContext context,
    BookingFormModel bookingFormModel,
  ) async {
    _isLoading = true;
    notifyListeners();

    final bookingService = BookingService();
    final response = await bookingService.postBookingFormModel(
      context,
      bookingFormModel,
    );

    _isLoading = false;

    if (response != null) {
      _bookingResponse = response;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Booking posted successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to post booking"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }

    notifyListeners();
  }

  void resetBookingFormModel() {
    _bookingFormModel = BookingFormModel();
    notifyListeners();
  }

  void setModelId(String value) {
    _bookingFormModel.modelId = value;
    notifyListeners();
  }

  void setBranch(String value) {
    _bookingFormModel.branch = value;
    notifyListeners();
  }

  void setColor(String value) {
    _bookingFormModel.modelColor = value;
    notifyListeners();
  }

  void setCustomerType(String value) {
    _bookingFormModel.customerType = value;
    notifyListeners();
  }

  void setGstin(String value) {
    _bookingFormModel.gstin = value;
    notifyListeners();
  }

  void setRto(String value) {
    _bookingFormModel.rtoType = value;
    notifyListeners();
  }

  void setRtoAmount(double value) {
    _bookingFormModel.rtoAmount = value;
    notifyListeners();
  }

  void setSalesExecuative(String value) {
    _bookingFormModel.salesExecutive = value;
    notifyListeners();
  }

  void setHpa(bool value) {
    _bookingFormModel.hpa = value;
    notifyListeners();
  }

  void setSalutation(String value) {
    _bookingFormModel.saluation = value;
    notifyListeners();
  }

  void setName(String value) {
    _bookingFormModel.customerName = value;
    notifyListeners();
  }

  void setBirthDate(String value) {
    _bookingFormModel.customerDob = value;
    notifyListeners();
  }

  void setOccupation(String value) {
    _bookingFormModel.customerOccupation = value;
    notifyListeners();
  }

  void setAddress(String value) {
    _bookingFormModel.customerAddress = value;
    notifyListeners();
  }

  void setTaluka(String value) {
    _bookingFormModel.customerTaluka = value;
    notifyListeners();
  }

  void setDistrict(String value) {
    _bookingFormModel.customerDistrict = value;
    notifyListeners();
  }

  void setPincode(String value) {
    _bookingFormModel.customerPincode = value;
    notifyListeners();
  }

  void setMobile1(String value) {
    _bookingFormModel.customerMobile1 = value;
    notifyListeners();
  }

  void setMobile2(String value) {
    _bookingFormModel.customerMobile2 = value;
    notifyListeners();
  }

  void setAadharNumber(String value) {
    _bookingFormModel.customerAadharNumber = value;
    notifyListeners();
  }

  void setNote(String value) {
    _bookingFormModel.note = value;
    notifyListeners();
  }

  void setPanNumber(String value) {
    _bookingFormModel.customerPanNo = value;
    notifyListeners();
  }

  void setNomineeName(String value) {
    _bookingFormModel.nomineeName = value;
    notifyListeners();
  }

  void setNomineeRelation(String value) {
    _bookingFormModel.nomineeRelation = value;
    notifyListeners();
  }

  void setNomineeAge(int value) {
    _bookingFormModel.nomineeAge = value;
    notifyListeners();
  }

  void setDiscount(double value) {
    _bookingFormModel.discountValue = value;
    notifyListeners();
  }

  void setExchange(bool value) {
    _bookingFormModel.isExchange = value;
    notifyListeners();
  }

  void setBroker(String value) {
    _bookingFormModel.brokerId = value;
    notifyListeners();
  }

  void setOtp(String value) {
    _bookingFormModel.otp = value;
    notifyListeners();
  }

  void setExchangePrice(int value) {
    _bookingFormModel.exchangePrice = value;
    notifyListeners();
  }

  void setVehicleNumber(String value) {
    _bookingFormModel.vehicleNumber = value;
    notifyListeners();
  }

  void setChassisNumber(String value) {
    _bookingFormModel.chassisNumber = value;
    notifyListeners();
  }

  void setPaymentType(String value) {
    _bookingFormModel.paymentType = value;
    notifyListeners();
  }

  void setFinancer(String value) {
    _bookingFormModel.financerId = value;
    notifyListeners();
  }

  void setScheme(String value) {
    _bookingFormModel.scheme = value;
    notifyListeners();
  }

  void setEmiDetails(String value) {
    _bookingFormModel.emiPlan = value;
    notifyListeners();
  }

  void setAccessories(List<String> value) {
    _bookingFormModel.accessoryIds = value;
    notifyListeners();
  }

  void setPriceComponents(List<String> value) {
    _bookingFormModel.optionalComponents = value;
    notifyListeners();
  }

  void setGcApplicable(bool value) {
    _bookingFormModel.gcApplicable = value;
    notifyListeners();
  }

  void setGcAmount(int value) {
    _bookingFormModel.gcAmount = value;
    notifyListeners();
  }
}
