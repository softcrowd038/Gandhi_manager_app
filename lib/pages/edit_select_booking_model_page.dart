// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

class EditSelectBookingModelPage extends StatefulWidget {
  final String? bookingId;
  const EditSelectBookingModelPage({super.key, required this.bookingId});

  @override
  State<EditSelectBookingModelPage> createState() =>
      _SelectBookingModelPageState();
}

class _SelectBookingModelPageState extends State<EditSelectBookingModelPage> {
  final searchController = TextEditingController();
  final dropDownEditingController = TextEditingController();
  final gstInEditingController = TextEditingController();
  String? selectedCustomerType;
  List<Model> filteredModels = [];
  final globleKey = GlobalKey<FormState>();
  bool _isInitialDataLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchBookingData();
    });
  }

  Future<void> _fetchBookingData() async {
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

      setState(() {
        selectedCustomerType = bookingData.customerType;
        dropDownEditingController.text = bookingData.customerType ?? '';
      });

      if (bookingData.gstin != null) {
        gstInEditingController.text = bookingData.gstin!;
        Provider.of<BookingFormProvider>(
          context,
          listen: false,
        ).setGstin(bookingData.gstin!);
      }

      if (bookingData.customerType != null) {
        final bikeModelProvider = Provider.of<BookingBikeModelProvider>(
          context,
          listen: false,
        );

        await bikeModelProvider.fetchBikeModels(
          context,
          bookingData.customerType!,
        );

        if (bikeModelProvider.bikeModels != null) {
          setState(() {
            filteredModels = bikeModelProvider.bikeModels!.data!.models;
          });

          if (bookingData.model?.id != null) {
            final selectedModel = filteredModels.firstWhere(
              (model) => model.id == bookingData.model?.id,
              orElse: () => Model(prices: []),
            );

            if (selectedModel.id != null) {
              final selectedModelsProvider =
                  Provider.of<SelectedModelsProvider>(context, listen: false);
              selectedModelsProvider.toggleModel(selectedModel);

              Provider.of<BookingFormProvider>(
                context,
                listen: false,
              ).setModelId(selectedModel.id ?? "");
            }
          }
        }
      }

      setState(() {
        _isInitialDataLoaded = true;
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    dropDownEditingController.dispose();
    gstInEditingController.dispose();
    super.dispose();
  }

  void filterModels(String query) {
    final bikeModelProvider = Provider.of<BookingBikeModelProvider>(
      context,
      listen: false,
    );
    final allModels = bikeModelProvider.bikeModels?.data!.models ?? [];
    setState(() {
      filteredModels = query.isEmpty
          ? allModels
          : allModels
                .where(
                  (model) => model.modelName!.toLowerCase().contains(
                    query.toLowerCase(),
                  ),
                )
                .toList();
    });
  }

  void toggleSelection(Model model) {
    final selectedModelsProvider = Provider.of<SelectedModelsProvider>(
      context,
      listen: false,
    );
    final bookingFormProvider = Provider.of<BookingFormProvider>(
      context,
      listen: false,
    );

    if (selectedModelsProvider.selectedModels.isNotEmpty &&
        !selectedModelsProvider.isSelected(model)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can select a maximum of 1 model')),
      );
      return;
    }
    bookingFormProvider.setModelId(model.id ?? "");
    selectedModelsProvider.toggleModel(model);
  }

  @override
  Widget build(BuildContext context) {
    final bikeModelProvider = Provider.of<BookingBikeModelProvider>(
      context,
      listen: false,
    );
    final selectedModelsProvider = Provider.of<SelectedModelsProvider>(
      context,
      listen: false,
    );

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
                  if (globleKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditModelDetailsBooking(
                          bookingId: widget.bookingId,
                        ),
                      ),
                    );
                  }
                }
              },
            );
          },
        ),
      ),
      body: Form(
        key: globleKey,
        child: Consumer<GetBookingsByIdProvider>(
          builder: (context, bookingProvider, _) {
            if (bookingProvider.isLoading && !_isInitialDataLoaded) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.height * 0.012,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomDropDownWithLeadingIcon(
                        dropDownEditingController: dropDownEditingController,
                        selectedCustomerType: ValueNotifier<String?>(
                          selectedCustomerType,
                        ),
                        entries: [
                          {"label": "B2C", "value": "B2C"},
                          {"label": "B2B", "value": "B2B"},
                          {"label": "CSD", "value": "CSD"},
                        ],
                        hintText: "Select Type",
                        setDefault: true,
                        label: "Customer Type",
                        icon: Icons.person,
                        onSelected: (String? value) async {
                          setState(() {
                            selectedCustomerType = value;
                          });
                          final bookingFormProvider =
                              Provider.of<BookingFormProvider>(
                                context,
                                listen: false,
                              );
                          bookingFormProvider.setCustomerType(value ?? "");
                          dropDownEditingController.text = value ?? '';

                          if (value != null && value.isNotEmpty) {
                            await bikeModelProvider.fetchBikeModels(
                              context,
                              value,
                            );
                            if (bikeModelProvider.bikeModels != null) {
                              setState(() {
                                filteredModels =
                                    bikeModelProvider.bikeModels!.data!.models;
                              });
                              selectedModelsProvider.clearModels();
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppDimensions.height1),
                if (selectedCustomerType == 'B2B')
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: SizeConfig.screenHeight * 0.016,
                    ),
                    child: CustomTextFieldOutlined(
                      controller: gstInEditingController,
                      hintText: 'Enter GSTIN Number',
                      obscureText: false,
                      suffixIcon: FontAwesomeIcons.indianRupeeSign,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter GSTIN';
                        }
                        if (!RegExp(value).hasMatch(gstinPattern)) {
                          return 'Please enter correct GSTIN format';
                        }
                        return null;
                      },
                      label: 'GSTIN number',
                      onChanged: (value) {
                        Provider.of<BookingFormProvider>(
                          context,
                          listen: false,
                        ).setGstin(value);
                      },
                      keyboardType: TextInputType.text,
                      suffixIconColor: Colors.green,
                    ),
                  ),
                SearchField(
                  controller: searchController,
                  onChanged: filterModels,
                  labelText: "Search model by name",
                ),
                Expanded(
                  child:
                      Consumer2<
                        BookingBikeModelProvider,
                        SelectedModelsProvider
                      >(
                        builder:
                            (
                              context,
                              bikeModelProvider,
                              selectedModelsProvider,
                              child,
                            ) {
                              if (bikeModelProvider.isLoading &&
                                  !_isInitialDataLoaded) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (bikeModelProvider.bikeModels == null) {
                                return const Center(
                                  child: Text('No bike models found.'),
                                );
                              }

                              final modelsList = filteredModels;

                              if (modelsList.isEmpty) {
                                return const Center(
                                  child: Text('No models match your search.'),
                                );
                              }

                              return ListView.builder(
                                key: const PageStorageKey<String>(
                                  'select_model_list',
                                ),
                                itemCount: modelsList.length,
                                itemBuilder: (context, index) {
                                  final model = modelsList[index];
                                  final isSelected = selectedModelsProvider
                                      .isSelected(model);

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
            );
          },
        ),
      ),
    );
  }
}
