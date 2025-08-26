import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_bookings_model.dart';

class AllBookingsProvider extends ChangeNotifier {
  AllBookingModel? _allBookingsModel;
  bool? _isLoading;
  String? _errorMessage;

  AllBookingModel? get allBookingsModel => _allBookingsModel;
  bool? get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> getBookingsProvider(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = AllBookingsService();
    final bookings = await service.getAllBookings(context);
    if (bookings != null) {
      _allBookingsModel = bookings;
      debugPrint(
        _allBookingsModel?.data?.bookings
            ?.map((booking) {
              return booking.customerDetails?.name;
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
