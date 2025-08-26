import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/dash_stats_model.dart';

class DashStatsProvider extends ChangeNotifier {
  DashStatsModel? _dashStatsModel;
  String? _errorMessage;
  bool? _isLoading;

  DashStatsModel? get dashStatsModel => _dashStatsModel;
  String? get errorMessage => _errorMessage;
  bool? get isLoading => _isLoading;

  Future<void> getDashStats(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final service = DashStatsService();
    final stats = await service.getDashStatsService(context);

    if (stats != null) {
      _dashStatsModel = stats;
      _errorMessage = null;
    } else {
      _errorMessage = 'Failed to fetch DashBoard Stats.';
    }

    _isLoading = false;
    notifyListeners();
  }
}
