// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/get_notification_model.dart';

class GetNotificationProvider extends ChangeNotifier {
  GetNotificationMOdel? _notificationModel;
  String? _errorMessage;
  bool _isLoading = false;
  List<String> _bookingIds = [];

  GetNotificationMOdel? get notificationModel => _notificationModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;
  List<String> get bookingIds => _bookingIds;

  Future<void> getNotifications(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = GetNotificationSerice();
    final result = await service.getNotifications(context);

    if (result != null) {
      _notificationModel = result;

      _bookingIds = result.data
          .map((element) => element.bookingId.toString())
          .where((id) => id.isNotEmpty)
          .toList();

      final service = PostMarkedAsView();

      service.postMarkedAsView(context, _bookingIds);
    } else {
      _errorMessage = 'Failed to fetch Notifications.';
      _bookingIds = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearBookingIds() {
    _bookingIds = [];
    notifyListeners();
  }
}
