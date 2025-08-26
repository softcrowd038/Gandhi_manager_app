import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_users_model.dart';
import 'package:gandhi_tvs/services/get_all_users_service.dart';

class GetAllUsersProvider extends ChangeNotifier {
  AllUsersModel? _allUsersModel;
  String? _errorMessage;
  bool _isLoading = false;

  AllUsersModel? get allUsersModel => _allUsersModel;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  Future<void> getAllUsersProvider(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    GetAllUsersService getAllUsersService = GetAllUsersService();

    final result = await getAllUsersService.getAllUsers(context);

    if (result != null) {
      _allUsersModel = result;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch Financers.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
