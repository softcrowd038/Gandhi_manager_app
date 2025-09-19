// update_booking_status_provider.dart

import 'package:gandhi_tvs/common/app_imports.dart';

class UpdateBookingStatusProvider extends ChangeNotifier {
  String? _status;
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _responseData;

  String? get status => _status;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get responseData => _responseData;

  Future<void> updateBookingStatus(BuildContext context, String id) async {
    _isLoading = true;
    _errorMessage = null;
    _status = null;
    _responseData = null;
    notifyListeners();

    try {
      final updateBookingStatusService = UpdateBookingStatusService();
      await updateBookingStatusService.updateBookingStatus(context, id);

      _status = 'APPROVED';
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      _status = 'FAILED';
      notifyListeners();
    }
  }

  void resetState() {
    _status = null;
    _isLoading = false;
    _errorMessage = null;
    _responseData = null;
    notifyListeners();
  }
}
