// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_bookings_model.dart';

class DownpaymentProvider with ChangeNotifier {
  String _bookingId = "";
  double _disbursementAmount = 0;
  double _downPaymentExpected = 0;
  bool _isDeviation = false;

  // Getters
  String get bookingId => _bookingId;
  double get disbursementAmount => _disbursementAmount;
  double get downPaymentExpected => _downPaymentExpected;
  bool get isDeviation => _isDeviation;

  // Setters
  void setBookingId(String value) {
    _bookingId = value;
    notifyListeners();
  }

  void setDisbursementAmount(double value) {
    _disbursementAmount = value;
    notifyListeners();
  }

  void setDownPaymentExpected(double value) {
    _downPaymentExpected = value;
    notifyListeners();
  }

  void setIsDeviation(bool value) {
    _isDeviation = value;
    notifyListeners();
  }

  void postDownpayment(
    BuildContext context,
    DownpaymentModel model,
    Booking booking,
  ) async {
    if (model.bookingId.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Booking ID is required")));
      return;
    }

    if (model.disbursementAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Disbursement amount must be greater than 0")),
      );
      return;
    }

    if (model.downPaymentExpected <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Downpayment expected must be greater than 0")),
      );
      return;
    }

    final service = AddDownpaymentService();
    await service.postAddDownPaymentModel(context, model).then((_) {
      handlePrintFinanceLetter(
        bookingData: booking,
        dealAmount: booking.discountedAmount?.toDouble() ?? 0.0,
        financeDisbursement: model.disbursementAmount,
        gcAmount: booking.payment.gcAmount?.toDouble() ?? 0.0,
        downPayment: model.downPaymentExpected,
      );
    });
  }
}
