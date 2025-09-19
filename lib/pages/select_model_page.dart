import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

class SelectModelPage extends StatefulWidget {
  const SelectModelPage({super.key});

  @override
  State<SelectModelPage> createState() => _SelectModelPageState();
}

class _SelectModelPageState extends State<SelectModelPage> {
  final TextEditingController searchController = TextEditingController();
  List<Model> filteredModels = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchBikeModels();
    });
  }

  Future<void> _fetchBikeModels() async {
    final bikeModelProvider = Provider.of<BikeModelProvider>(
      context,
      listen: false,
    );
    final selectedModelsProvider = Provider.of<SelectedModelsProvider>(
      context,
      listen: false,
    );
    await bikeModelProvider.fetchBikeModels(context);

    if (bikeModelProvider.bikeModels != null) {
      setState(() {
        filteredModels = bikeModelProvider.bikeModels!.data!.models;
      });
      selectedModelsProvider.clearModels();
    }
  }

  void toggleSelection(Model model) {
    // Check if model has a valid ID
    if (model.id == null || model.id!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cannot select a model without a valid ID'),
        ),
      );
      return;
    }

    final selectedModelsProvider = Provider.of<SelectedModelsProvider>(
      context,
      listen: false,
    );

    if (selectedModelsProvider.selectedModels.length >= 2 &&
        !selectedModelsProvider.isSelected(model)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can select a maximum of 2 models')),
      );
      return;
    }
    selectedModelsProvider.toggleModel(model);
  }

  void filterModels(String query) {
    final bikeModelProvider = Provider.of<BikeModelProvider>(
      context,
      listen: false,
    );
    final allModels = bikeModelProvider.bikeModels?.data!.models ?? [];

    setState(() {
      if (query.isEmpty) {
        filteredModels = allModels;
      } else {
        filteredModels = allModels
            .where(
              (model) =>
                  model.modelName!.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        title: Consumer<SelectedModelsProvider>(
          builder: (context, selectedModelsProvider, _) {
            return StepsAppbar(
              title: "Step 1",
              subtitle: "Select Bike Model",
              color: selectedModelsProvider.selectedModels.isEmpty
                  ? AppColors.divider
                  : AppColors.primary,
              onTap: () {
                if (selectedModelsProvider.selectedModels.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please select at least one model'),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterCustomerPage(),
                    ),
                  );
                }
              },
            );
          },
        ),
      ),
      body: Column(
        children: [
          SearchField(
            controller: searchController,
            onChanged: filterModels,
            labelText: "search model by name",
          ),
          Expanded(
            child: Consumer2<BikeModelProvider, SelectedModelsProvider>(
              builder:
                  (context, bikeModelProvider, selectedModelsProvider, child) {
                    if (bikeModelProvider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (bikeModelProvider.bikeModels == null) {
                      return const Center(child: Text('No bike models found.'));
                    }

                    final modelsList = filteredModels;

                    if (modelsList.isEmpty) {
                      return const Center(
                        child: Text('No models match your search.'),
                      );
                    }

                    return ListView.builder(
                      key: const PageStorageKey<String>('select_model_list'),
                      itemCount: modelsList.length,
                      itemBuilder: (context, index) {
                        final model = modelsList[index];
                        final isSelected = selectedModelsProvider.isSelected(
                          model,
                        );

                        return GestureDetector(
                          onTap: () => toggleSelection(model),
                          child: SelectItemCard(
                            title: model.modelName ?? "",
                            isSelected: isSelected,
                          ),
                        );
                      },
                    );
                  },
            ),
          ),
        ],
      ),
    );
  }
}
