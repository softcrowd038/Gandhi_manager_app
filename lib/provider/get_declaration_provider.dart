import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/declaration_model.dart';

class GetDeclarationProvider extends ChangeNotifier {
  DeclarationModel? _declarationModel;
  String? _errorMessage;
  bool _isLoading = false;

  DeclarationModel? get declarationModel => _declarationModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getDeclarations(BuildContext context, String? formType) async {
    _isLoading = true;
    notifyListeners();

    final service = GetDeclarationSerice();
    final result = await service.getDeclarations(context, formType);

    if (result != null) {
      _declarationModel = result;
    } else {
      _errorMessage = 'Failed to fetch Declarations.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
