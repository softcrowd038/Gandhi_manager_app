// ignore_for_file: unnecessary_null_comparison

import 'package:gandhi_tvs/common/app_imports.dart' hide Price;
import 'package:gandhi_tvs/pages/edit_discount_page_booking.dart';
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
        final bookingData = getBookingByIdProvider.bookings!.data!;
        final bookingFormProvider = Provider.of<BookingFormProvider>(
          context,
          listen: false,
        );

        // Get pre-selected accessory IDs from booking data
        _preSelectedAccessoryIds = bookingData.accessories
            .map((accessory) => accessory.accessory?.id ?? "")
            .where((id) => id != null)
            .toList();

        // Update provider with fetched data
        bookingFormProvider.setAccessories(_preSelectedAccessoryIds);

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

          final selectedModelsHeadersProvider =
              Provider.of<ModelHeadersProvider>(context, listen: false);
          await selectedModelsHeadersProvider.fetchModelHeaders(
            context,
            modelId,
          );

          // Pre-select accessories based on booking data
          final selectedAccessoriesProvider =
              Provider.of<SelectedAccessoriesProvider>(context, listen: false);

          // Clear any previous selections
          selectedAccessoriesProvider.clearAccessories();

          // Select accessories that were in the booking
          if (accessoriesProvider.accessoriesModel?.data?.accessories != null) {
            for (var accessory
                in accessoriesProvider.accessoriesModel!.data!.accessories!) {
              if (_preSelectedAccessoryIds.contains(accessory.id)) {
                selectedAccessoriesProvider.toggleAccessory(
                  accessory.name ?? "",
                );
              }
            }
          }
        }

        setState(() {
          _isInitialDataLoaded = true;
        });
      }
    } catch (e) {
      print('Error fetching booking data: $e');
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

  @override
  Widget build(BuildContext context) {
    final bookingFormProvider = Provider.of<BookingFormProvider>(
      context,
      listen: false,
    );

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
                          final isPreSelected = _preSelectedAccessoryIds
                              .contains(accessory.id);

                          return Consumer<SelectedAccessoriesProvider>(
                            builder: (context, selectedProvider, _) {
                              // Initialize selection state for pre-selected items
                              if (_isInitialDataLoaded &&
                                  isPreSelected &&
                                  !selectedProvider.isSelected(
                                    accessory.name ?? "",
                                  )) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  selectedProvider.toggleAccessory(
                                    accessory.name ?? "",
                                  );
                                });
                              }

                              return ContainerWithNameAndPrice(
                                accessoryName: accessory.name ?? "",
                                accessoryValue: accessory.price?.toInt() ?? 0,

                                onSelectionChanged: () {
                                  final selectedAccessoriesIds = <String>[];

                                  for (var acc in accessoriesList) {
                                    if (selectedProvider.isSelected(
                                      acc.name ?? "",
                                    )) {
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
