import 'package:gandhi_tvs/common/app_imports.dart';

class DocumentDetailsProvider with ChangeNotifier {
  DocumentModel? _documentDetails;
  bool _isLoading = false;
  String? _errorMessage;

  DocumentModel? get documentDetails => _documentDetails;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchDocumentDetails(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = DocumentDetailsService();
    final documents = await service.getAllFinanceDocumnts(context);

    if (documents != null) {
      _documentDetails = documents;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch documents.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
