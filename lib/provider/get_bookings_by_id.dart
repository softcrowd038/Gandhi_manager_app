import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/get_booking_by_id.dart';

class GetBookingsByIdProvider with ChangeNotifier {
  GetBookingsByIdModel? _bookings;
  bool _isLoading = false;
  String? _errorMessage;

  GetBookingsByIdModel? get bookings => _bookings;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchBookingsById(BuildContext context, String bookingId) async {
    _isLoading = true;
    notifyListeners();

    final service = GetBookingByIdService();
    final models = await service.getBookingsById(context, bookingId);

    if (models != null) {
      _bookings = models;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Bookings.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
