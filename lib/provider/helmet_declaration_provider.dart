// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';

class GetHelmetDeclarationProvider with ChangeNotifier {
  Uint8List? _helmetDeclarationPdf;
  bool _isLoading = false;

  Uint8List? get helmetDeclarationPdf => _helmetDeclarationPdf;
  bool get isLoading => _isLoading;

  Future<void> getHelmetDeclarations(
    BuildContext context,
    String chassisNumber,
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      final service = GetHelmetDeclarationService();
      final response = await service.getDeclarations(context, chassisNumber);

      if (response != null) {
        _helmetDeclarationPdf = response; // Already Uint8List
      }
    } catch (e) {
      debugPrint('Error getting helmet declaration: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to get helmet declaration')),
      );
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearPdf() {
    _helmetDeclarationPdf = null;
    notifyListeners();
  }
}
