import 'package:gandhi_tvs/common/app_imports.dart';

class SelectedAccessoriesProvider with ChangeNotifier {
  final List<String> _selectedAccessories = [];

  List<String> get selectedAccessories => _selectedAccessories;

  void toggleAccessory(String accessoryName) {
    if (_selectedAccessories.contains(accessoryName)) {
      _selectedAccessories.remove(accessoryName);
    } else {
      _selectedAccessories.add(accessoryName);
    }
    notifyListeners();
  }

  bool isSelected(String accessoryName) =>
      _selectedAccessories.contains(accessoryName);

  void clearAccessories() {
    _selectedAccessories.clear();
    notifyListeners();
  }
}
