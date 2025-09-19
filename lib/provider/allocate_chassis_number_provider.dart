// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';

class AllocateChassisProvider extends ChangeNotifier {
  bool _isLoading = false;
  Map<String, dynamic>? _allocationResponse;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  Map<String, dynamic>? get allocationResponse => _allocationResponse;
  String? get errorMessage => _errorMessage;

  Future<void> allocateChassis(
    BuildContext context,
    String? id,
    ChassisAllocationModel? chassisAllocateModel,
  ) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final allocateChassisService = AllocateChassisService();
    final response = await allocateChassisService.allocateChassis(
      context,
      id,
      chassisAllocateModel ??
          ChassisAllocationModel(
            chassisNumber: chassisAllocateModel!.chassisNumber,
          ),
    );

    _isLoading = false;

    if (response != null) {
      _allocationResponse = response;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Chassis allocated successfully"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationPage(index: 4)),
      );
    } else {
      _errorMessage = "Failed to allocate chassis";
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to allocate chassis"),
          backgroundColor: Colors.redAccent,
        ),
      );
    }

    notifyListeners();
  }

  void reset() {
    _isLoading = false;
    _allocationResponse = null;
    _errorMessage = null;
    notifyListeners();
  }

  // Optional: Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
