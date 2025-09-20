// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart' hide Price;
import 'package:gandhi_tvs/widgets/edit_container_with_name_and_price.dart';
import 'package:provider/provider.dart';
import 'package:gandhi_tvs/models/model_headers.dart';

class EditAccessoriesDetailsBooking extends StatefulWidget {
  final String? bookingId;

  const EditAccessoriesDetailsBooking({super.key, required this.bookingId});

  @override
  State<EditAccessoriesDetailsBooking> createState() =>
      _EditAccessoriesDetailsBookingState();
}

class _EditAccessoriesDetailsBookingState
    extends State<EditAccessoriesDetailsBooking> {
  bool _isLoading = false;
  bool _isInitialDataLoaded = false;
  List<String> _preSelectedAccessoryIds = [];
  List<String> _selectedAccessoryIds = [];
  Map<String, bool> _accessorySelectionState = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.bookingId != null) {
        _fetchBookingData();
      }
    });
  }

  Future<void> _fetchBookingData() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final getBookingByIdProvider = Provider.of<GetBookingsByIdProvider>(
        context,
        listen: false,
      );

      await getBookingByIdProvider.fetchBookingsById(
        context,
        widget.bookingId ?? "",
      );

      if (getBookingByIdProvider.bookings?.data != null) {
        final bookingData = getBookingByIdProvider.bookings!.data;
        final bookingFormProvider = Provider.of<BookingFormProvider>(
          context,
          listen: false,
        );

        // Get pre-selected accessory IDs from booking data
        _preSelectedAccessoryIds = bookingData.accessories
            .map((accessory) => accessory.accessory?.id ?? "")
            .where((id) => id.isNotEmpty)
            .toList();

        _selectedAccessoryIds = List.from(_preSelectedAccessoryIds);

        // Update provider with fetched data
        bookingFormProvider.setAccessories(_selectedAccessoryIds);

        // Load accessories for the model
        final selectedModelsProvider = Provider.of<SelectedModelsProvider>(
          context,
          listen: false,
        );

        if (selectedModelsProvider.selectedModels.isNotEmpty) {
          final modelId = selectedModelsProvider.selectedModels.first.id;

          final accessoriesProvider = Provider.of<AccessoriesProvider>(
            context,
            listen: false,
          );
          await accessoriesProvider.getAllAccessoriesByModel(context, modelId);

          // Initialize selection state
          if (accessoriesProvider.accessoriesModel?.data?.accessories != null) {
            for (var accessory
                in accessoriesProvider.accessoriesModel!.data!.accessories) {
              if (accessory.id != null) {
                _accessorySelectionState[accessory.id!] = _selectedAccessoryIds
                    .contains(accessory.id);
              }
            }
          }

          final selectedModelsHeadersProvider =
              Provider.of<ModelHeadersProvider>(context, listen: false);
          await selectedModelsHeadersProvider.fetchModelHeaders(
            context,
            modelId,
          );
        }

        setState(() {
          _isInitialDataLoaded = true;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load accessories data: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _toggleAccessorySelection(String accessoryId, String accessoryName) {
    setState(() {
      if (_selectedAccessoryIds.contains(accessoryId)) {
        _selectedAccessoryIds.remove(accessoryId);
        _accessorySelectionState[accessoryId] = false;
      } else {
        _selectedAccessoryIds.add(accessoryId);
        _accessorySelectionState[accessoryId] = true;
      }
    });

    final bookingFormProvider = Provider.of<BookingFormProvider>(
      context,
      listen: false,
    );
    bookingFormProvider.setAccessories(_selectedAccessoryIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: StepsAppbarPlain(
          title: 'Step 5',
          subtitle: 'Select Accessories',
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: AppPadding.p2,
                  child: Consumer<ModelHeadersProvider>(
                    builder: (context, value, _) {
                      final prices =
                          value.modelHeaders?.data?.model.prices ?? [];

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

                      return ListView.builder(
                        itemCount: accessoriesList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final accessory = accessoriesList[index];
                          final accessoryId = accessory.id ?? "";
                          final accessoryName = accessory.name ?? "";
                          final isSelected =
                              _accessorySelectionState[accessoryId] ?? false;

                          return EditContainerWithNameAndPrice(
                            accessoryName: accessoryName,
                            accessoryValue: accessory.price?.toInt() ?? 0,
                            accessoryId: accessoryId,
                            isSelected: isSelected,
                            onSelectionChanged: () {
                              _toggleAccessorySelection(
                                accessoryId,
                                accessoryName,
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
            MaterialPageRoute(
              builder: (context) =>
                  EditDiscountPageBooking(bookingId: widget.bookingId),
            ),
          );
        },
      ),
    );
  }
}
