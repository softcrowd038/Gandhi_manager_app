import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/services/verify_pending_request.dart';

class VerifyUpdatedRequestProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _updateResponse;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get updateResponse => _updateResponse;

  Future<void> verifyUpdateRequest(
    BuildContext context,
    String? id,
    String? status,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final updateBookingService = VerifyPendingRequest();
      final response = await updateBookingService.approvePendingRequests(
        context,
        id,
        status,
      );

      if (response != null) {
        _updateResponse = response;
        _errorMessage = null;

        // Show appropriate success message based on status
        final action = status == "APPROVED" ? "approved" : "rejected";
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Update request $action successfully"),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );

        // Optional: Navigate back after successful operation
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pop(context, true); // Return success flag
        });
      } else {
        _errorMessage = "Failed to process request";
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to process request"),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      _errorMessage = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.redAccent,
          duration: const Duration(seconds: 3),
        ),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear any existing error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  // Reset the entire provider state
  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _updateResponse = null;
    notifyListeners();
  }

  // Check if the operation was successful
  bool get isSuccess => _updateResponse != null && _errorMessage == null;

  // Get the response message if available
  String? get responseMessage {
    if (_updateResponse != null && _updateResponse!.containsKey('message')) {
      return _updateResponse!['message'];
    }
    return null;
  }
}
