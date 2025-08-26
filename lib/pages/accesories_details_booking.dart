import 'package:gandhi_tvs/common/app_imports.dart' hide Price;
import 'package:provider/provider.dart';
import 'package:gandhi_tvs/models/model_headers.dart';

class AccessoriesDetailsBooking extends HookWidget {
  const AccessoriesDetailsBooking({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedAccessories = useState<List<bool>>([]);
    final bookingFormProvider = Provider.of<BookingFormProvider>(
      context,
      listen: false,
    );

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final selectedAccessoriesProvider =
            Provider.of<SelectedAccessoriesProvider>(context, listen: false);

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

          await selectedModelsHeadersProvider.fetchModelHeaders(
            context,
            modelId,
          );
        }
      });
      return null;
    }, []);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: StepsAppbarPlain(
          title: 'Step 5',
          subtitle: 'Select Accessories',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: AppPadding.p2,
            child: Consumer<ModelHeadersProvider>(
              builder: (context, value, _) {
                final prices = value.modelHeaders?.data?.model.prices ?? [];

                final accessoriesTotalItem = prices.firstWhere(
                  (item) => item.headerKey == "ACCESSORIES TOTAL",
                  orElse: () => Price(
                    value: 0,
                    headerId: null,
                    headerKey: "ACCESSORIES TOTAL",
                    categoryKey: null,
                    priority: 0,
                    isMandatory: false,
                    isDiscount: false,
                    metadata: null,
                    branchId: null,
                    branchName: null,
                    branchCity: null,
                  ),
                );

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: Colors.red,
                          size: AppDimensions.height1,
                        ),
                        SizedBox(width: SizeConfig.screenWidth * 0.04),
                        Text(
                          accessoriesTotalItem.headerKey ?? "",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: AppFontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "₹${accessoriesTotalItem.value.toString()}",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: Consumer<AccessoriesProvider>(
              builder: (context, value, _) {
                final accessoriesList =
                    value.accessoriesModel?.data?.accessories;

                if (value.isLoading == true) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (accessoriesList == null) {
                  return const Center(
                    child: Text("Failed to load accessories."),
                  );
                }

                if (accessoriesList.isEmpty) {
                  return Center(
                    child: Text(
                      "No accessories available for this model.",
                      style: TextStyle(
                        fontSize: AppFontSize.s18,
                        color: Colors.grey,
                      ),
                    ),
                  );
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (selectedAccessories.value.length <
                      accessoriesList.length) {
                    selectedAccessories.value = List<bool>.filled(
                      accessoriesList.length,
                      false,
                    );
                  }
                });

                return ListView.builder(
                  itemCount: accessoriesList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final accessory = accessoriesList[index];
                    return ContainerWithNameAndPrice(
                      accessoryName: accessory.name ?? "",
                      accessoryValue: accessory.price ?? 0,
                      onSelectionChanged: () {
                        final selectedAccessoriesIds = <String>[];
                        final selectedProvider =
                            Provider.of<SelectedAccessoriesProvider>(
                              context,
                              listen: false,
                            );

                        for (var acc in accessoriesList) {
                          if (selectedProvider.isSelected(acc.name ?? "")) {
                            if (acc.id != null) {
                              selectedAccessoriesIds.add(acc.id!);
                            }
                          }
                        }

                        bookingFormProvider.setAccessories(
                          selectedAccessoriesIds,
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DiscountPageBooking()),
          );
        },
      ),
    );
  }
}
