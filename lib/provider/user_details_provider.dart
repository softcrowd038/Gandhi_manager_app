// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/user_details.dart';

class UserDetailsProvider with ChangeNotifier {
  bool _isLoading = false;
  UserDetails? _userDetails;

  bool get isLoading => _isLoading;
  UserDetails? get userDetails => _userDetails;

  Future<void> fetchUserDetails(BuildContext context) async {
    _isLoading = true;

    final userDetailsService = GetUserDetails();
    final response = await userDetailsService.getUserDetails(context);

    _isLoading = false;

    if (response != null && response.success == true) {
      _userDetails = userDetailsFromJson(json.encode(response));
    }

    notifyListeners();
  }
}
