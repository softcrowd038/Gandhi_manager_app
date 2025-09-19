// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';

class UpdateBookingProvider extends ChangeNotifier {
  bool _isLoading = false;
  Map<String, dynamic>? _updateResponse;

  bool get isLoading => _isLoading;
  Map<String, dynamic>? get updateResponse => _updateResponse;

  Future<void> updateBooking(
    BuildContext context,
    String? id,
    BookingFormModel? bookingFormModel,
  ) async {
    _isLoading = true;
    notifyListeners();

    final updateBookingService = UpdateBookingService();
    final response = await updateBookingService.updateBooking(
      context,
      id,
      bookingFormModel,
    );

    _isLoading = false;

    if (response != null) {
      _updateResponse = response;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Booking updated successfully"),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to update booking"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }

    notifyListeners();
  }

  void reset() {
    _isLoading = false;
    _updateResponse = null;
    notifyListeners();
  }
}
