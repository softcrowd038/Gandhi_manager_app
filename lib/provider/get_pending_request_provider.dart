import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/pending_update_model.dart';
import 'package:gandhi_tvs/services/get_pending_requests.dart';

class GetPendingRequestsProvider with ChangeNotifier {
  PendingUpdateModel? _pendingRequests;
  bool _isLoading = false;
  String? _errorMessage;

  PendingUpdateModel? get pendingRequests => _pendingRequests;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPendingRequests(
    BuildContext context,
    String bookingId,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final service = GetPendingRequestsService();
    final models = await service.getPendingRequests(context, bookingId);

    if (models != null) {
      _pendingRequests = models;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch pending requests.';
    }

    _isLoading = false;
    notifyListeners();
  }

  void clear() {
    _pendingRequests = null;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}
