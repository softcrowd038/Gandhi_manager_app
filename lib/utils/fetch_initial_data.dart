// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

Future<void> fetchInitialData(BuildContext context) async {
  final monthlyStatProvider = Provider.of<GetMonthQuotations>(
    context,
    listen: false,
  );
  monthlyStatProvider.fetchMonthStatsofQuotations(context);
  final dailyStatProvider = Provider.of<GetTodayQuotations>(
    context,
    listen: false,
  );
  dailyStatProvider.fetchDayStatsofQuotations(context);
  final bikeModelProvider = Provider.of<BikeModelProvider>(
    context,
    listen: false,
  );
  bikeModelProvider.fetchBikeModels(context);

  final userProvider = Provider.of<UserDetailsProvider>(context, listen: false);
  userProvider.fetchUserDetails(context);

  final dashProvider = Provider.of<DashStatsProvider>(context, listen: false);
  dashProvider.getDashStats(context);

  final selectedAccessoriesProvider = Provider.of<SelectedAccessoriesProvider>(
    context,
    listen: false,
  );

  selectedAccessoriesProvider.clearAccessories();
  final selectedModelsProvider = Provider.of<SelectedModelsProvider>(
    context,
    listen: false,
  );

  final selectedModelsHeadersProvider = Provider.of<ModelHeadersProvider>(
    context,
    listen: false,
  );

  if (selectedModelsProvider.selectedModels.isNotEmpty) {
    final modelId = selectedModelsProvider.selectedModels.first.id;

    final accessoriesProvider = Provider.of<AccessoriesProvider>(
      context,
      listen: false,
    );
    accessoriesProvider.getAllAccessoriesByModel(context, modelId);

    await selectedModelsHeadersProvider.fetchModelHeaders(context, modelId);

    final getAllQuotations = Provider.of<AllQuotationProvider>(
      context,
      listen: false,
    );
    getAllQuotations.fetchQuotations(context);

    final selectedModelsProvider1 = Provider.of<SelectedModelsProvider>(
      context,
      listen: false,
    );
    final modelId2 = selectedModelsProvider1.selectedModels.first.id;
    final modelHeadersProvider = Provider.of<ModelHeadersProvider>(
      context,
      listen: false,
    );

    await modelHeadersProvider.fetchModelHeaders(context, modelId2);

    final branchId = Provider.of<UserDetailsProvider>(
      context,
      listen: false,
    ).userDetails?.data?.branch;
    Provider.of<ExchangeBrokerProvider>(
      context,
      listen: false,
    ).fetchExchangeBroker(context, branchId ?? "");

    final selectedModelsProvider2 = Provider.of<SelectedModelsProvider>(
      context,
      listen: false,
    );
    final modelId3 = selectedModelsProvider2.selectedModels.first.id;
    final colorsProvider = Provider.of<ColorsProvider>(context, listen: false);
    colorsProvider.fetchBikeModelsColor(context, modelId3 ?? "");

    final modelHeadersProvider1 = Provider.of<ModelHeadersProvider>(
      context,
      listen: false,
    );
    modelHeadersProvider1.fetchModelHeaders(context, modelId3 ?? "");

    Provider.of<FinancerProvider>(
      context,
      listen: false,
    ).fetchFinancers(context);
  }
}
