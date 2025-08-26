import 'package:gandhi_tvs/common/app_imports.dart';

class SelectedModelsProvider with ChangeNotifier {
  final Set<Model> _selectedModels = {};

  Set<Model> get selectedModels => _selectedModels;

  void toggleModel(Model model) {
    if (_selectedModels.contains(model)) {
      _selectedModels.remove(model);
    } else {
      if (_selectedModels.length >= 2) {
        return;
      }
      _selectedModels.add(model);
    }
    notifyListeners();
  }

  bool isSelected(Model model) => _selectedModels.contains(model);

  void clearModels() {
    _selectedModels.clear();
    notifyListeners();
  }
}
