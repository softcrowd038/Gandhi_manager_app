// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/inward_model_details.dart';
import 'package:provider/provider.dart';

class BikeModelsDetails extends HookWidget {
  const BikeModelsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final inwardProvider = Provider.of<InwardedModelsProvider>(context);
    final userDetails = Provider.of<UserDetailsProvider>(context);
    final searchController = useTextEditingController();
    final filteredList = useState<List<Vehicle>>([]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        userDetails.fetchUserDetails(context);
        await inwardProvider.getInwardedModelProvider(
          context,
          userDetails.userDetails?.data?.branch ?? "",
        );
        filteredList.value =
            inwardProvider.inwardModelDetails?.data?.vehicles ?? [];
      });
      return null;
    }, []);

    void filterModels(String query) {
      final allModels = inwardProvider.inwardModelDetails?.data?.vehicles ?? [];
      if (query.isEmpty) {
        filteredList.value = allModels;
      } else {
        filteredList.value = allModels
            .where(
              (vehicle) => (vehicle.modelName ?? '').toLowerCase().contains(
                query.toLowerCase(),
              ),
            )
            .toList();
      }
    }

    return Column(
      children: [
        SearchField(
          controller: searchController,
          onChanged: filterModels,
          labelText: "Search model by name",
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Consumer<InwardedModelsProvider>(
            builder: (context, inwardModelProvider, _) {
              if (inwardModelProvider.isLoading ?? false) {
                return Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }
              if (filteredList.value.isEmpty) {
                return Center(
                  child: Text(
                    "No model available",
                    style: TextStyle(
                      fontSize: AppFontSize.s18,
                      fontWeight: AppFontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: filteredList.value.length,
                itemBuilder: (context, index) {
                  final vehicle = filteredList.value[index];
                  return Padding(
                    padding: AppPadding.p2,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ListTile(
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: AppBorderRadius.r2,
                        ),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                vehicle.modelName ?? "Loading model name...",
                                style: TextStyle(
                                  fontSize: AppFontSize.s20,
                                  fontWeight: AppFontWeight.bold,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                vehicle.type?.name ?? "",
                                style: TextStyle(
                                  fontSize: AppFontSize.s18,
                                  fontWeight: AppFontWeight.w500,
                                  color: AppColors.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if ((vehicle.colors).isNotEmpty)
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: vehicle.colors.map((colorModel) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        right: 8.0,
                                      ),
                                      child: ColorLabelNoValueRow(
                                        color: Colors.black,
                                        label:
                                            vehicle.color?.name ?? colorModel,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            InwardModelStatusContainer(
                              label: vehicle.status.toString(),
                              status1: vehicle.status.toString(),
                            ),
                            const SizedBox(height: 8),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  vehicle.chassisNumber != ""
                                      ? ColorLabelRow(
                                          color: AppColors.accent,
                                          label: "Chassis Number",
                                          value: vehicle.chassisNumber,
                                        )
                                      : SizedBox.shrink(),
                                  vehicle.motorNumber != ""
                                      ? ColorLabelRow(
                                          color: AppColors.error,
                                          label: "Motor Number",
                                          value: vehicle.motorNumber,
                                        )
                                      : SizedBox.shrink(),
                                  vehicle.batteryNumber != ""
                                      ? ColorLabelRow(
                                          color: AppColors.primary,
                                          label: "Battery Number",
                                          value: vehicle.batteryNumber,
                                        )
                                      : SizedBox.shrink(),
                                  vehicle.keyNumber != ""
                                      ? ColorLabelRow(
                                          color: AppColors.success,
                                          label: "Key Number",
                                          value: vehicle.keyNumber,
                                        )
                                      : SizedBox.shrink(),
                                  vehicle.engineNumber != ""
                                      ? ColorLabelRow(
                                          color: AppColors.secondary,
                                          label: "Engine Number",
                                          value: vehicle.engineNumber,
                                        )
                                      : SizedBox.shrink(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
