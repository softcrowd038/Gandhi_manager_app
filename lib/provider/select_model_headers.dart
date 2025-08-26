import 'package:gandhi_tvs/common/app_imports.dart';

class SelectedModelHeadersProvider extends ChangeNotifier {
  final Set<String> _selectedHeaders = {};

  bool isSelected(String header) => _selectedHeaders.contains(header);

  void toggleHeader(String header) {
    if (_selectedHeaders.contains(header)) {
      _selectedHeaders.remove(header);
    } else {
      _selectedHeaders.add(header);
    }
    notifyListeners();
  }

  void clearSelections() {
    _selectedHeaders.clear();
    notifyListeners();
  }

  void initializeSelections(List<String> defaultSelections) {
    _selectedHeaders.addAll(defaultSelections);
    notifyListeners();
  }

  List<String> get selectedHeaders => _selectedHeaders.toList();
}
