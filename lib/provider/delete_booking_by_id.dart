// DeleteBookingProvider
// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';

class DeleteBookingProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool _isDeleted = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  bool get isDeleted => _isDeleted;
  String? get errorMessage => _errorMessage;

  Future<bool> deleteBookingById(BuildContext context, String? id) async {
    _isLoading = true;
    _isDeleted = false;
    _errorMessage = null;
    notifyListeners();

    final deleteBookingService = DeleteBookingService();
    final success = await deleteBookingService
        .deleteBookingById(context, id)
        .then((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NavigationPage(index: 3)),
          );
        });

    _isLoading = false;

    if (success) {
      _isDeleted = true;
      notifyListeners();
      return true;
    } else {
      _errorMessage = "Failed to delete booking";
      notifyListeners();
      return false;
    }
  }

  void reset() {
    _isLoading = false;
    _isDeleted = false;
    _errorMessage = null;
    notifyListeners();
  }
}
