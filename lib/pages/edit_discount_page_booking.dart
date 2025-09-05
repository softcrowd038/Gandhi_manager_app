// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/provider/update_booking_provider.dart';
import 'package:provider/provider.dart';

class EditDiscountPageBooking extends StatefulWidget {
  final String? bookingId;

  const EditDiscountPageBooking({super.key, required this.bookingId});

  @override
  State<EditDiscountPageBooking> createState() =>
      _EditDiscountPageBookingState();
}

class _EditDiscountPageBookingState extends State<EditDiscountPageBooking> {
  final discountController = TextEditingController();
  bool _isLoading = false;
  bool _isInitialDataLoaded = false;
  GlobalKey<FormState> globalKey = GlobalKey();
  bool _isDisposed = false; // Add this flag

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_isDisposed) return; // Check if disposed before proceeding

      final selectedModelsProvider = Provider.of<SelectedModelsProvider>(
        context,
        listen: false,
      );

      if (selectedModelsProvider.selectedModels.isNotEmpty) {
        final modelId = selectedModelsProvider.selectedModels.first.id;
        final modelHeadersProvider = Provider.of<ModelHeadersProvider>(
          context,
          listen: false,
        );

        await modelHeadersProvider.fetchModelHeaders(context, modelId);
      }

      if (widget.bookingId != null) {
        _fetchBookingData();
      }
    });
  }

  Future<void> _fetchBookingData() async {
    if (_isLoading || _isDisposed) return; // Check if disposed

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

      if (_isDisposed) return; // Check if disposed after async operation

      if (getBookingByIdProvider.bookings?.data != null) {
        final bookingData = getBookingByIdProvider.bookings!.data!;
        final bookingFormProvider = Provider.of<BookingFormProvider>(
          context,
          listen: false,
        );

        final discount =
            bookingData.totalAmount! - bookingData.discountedAmount!;

        if (!_isDisposed) {
          // Check before calling setState
          setState(() {
            discountController.text = discount.toString();
          });
        }

        bookingFormProvider.setDiscount(discount);

        final selectedModelsProvider = Provider.of<SelectedModelsProvider>(
          context,
          listen: false,
        );

        if (selectedModelsProvider.selectedModels.isNotEmpty) {
          final modelId = selectedModelsProvider.selectedModels.first.id;
          final modelHeadersProvider = Provider.of<ModelHeadersProvider>(
            context,
            listen: false,
          );

          await modelHeadersProvider.fetchModelHeaders(context, modelId);

          if (!_isDisposed) {
            // Check before calling setState
            setState(() {
              _isInitialDataLoaded = true;
            });
          }
        }
      }
    } catch (e) {
      if (_isDisposed) return; // Don't show error if disposed
      print('Error fetching booking data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load discount data: $e'),
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
  void dispose() {
    _isDisposed = true; // Set the flag when disposing
    discountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BookingFormProvider bookingFormProvider = Provider.of<BookingFormProvider>(
      context,
      listen: false,
    );

    UpdateBookingProvider updateBookingFormProvider =
        Provider.of<UpdateBookingProvider>(context, listen: false);
    UserDetailsProvider userDetailsProvider = Provider.of<UserDetailsProvider>(
      context,
      listen: false,
    );
    SelectedModelHeadersProvider selectedModelHeadersProvider =
        Provider.of<SelectedModelHeadersProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: StepsAppbarPlain(title: "Final Steps", subtitle: "Add Discount"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: globalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: AppPadding.p2,
                          child: Text(
                            "Add Discount Amount Here",
                            style: TextStyle(
                              fontWeight: AppFontWeight.bold,
                              fontSize: AppFontSize.s18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: AppPadding.p2,
                          child: OutlinedBorderTextfieldWidget(
                            label: "Discount",
                            hintText: "xxx",
                            suffixIcon: Icons.currency_rupee,
                            suffixIconColor: Colors.grey,
                            controller: discountController,
                            onChanged: (value) {
                              bookingFormProvider.setDiscount(
                                int.tryParse(value) ?? 0,
                              );
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter Discount';
                              }
                              if (int.tryParse(value) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                            obscureText: false,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        Padding(
                          padding: AppPadding.p2,
                          child: Text(
                            "Price Headers",
                            style: TextStyle(
                              fontWeight: AppFontWeight.bold,
                              fontSize: AppFontSize.s18,
                            ),
                          ),
                        ),
                        Consumer<ModelHeadersProvider>(
                          builder: (context, value, _) {
                            final prices =
                                value.modelHeaders?.data?.model.prices;

                            if (value.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (prices == null) {
                              return const Center(
                                child: Text("Failed to load price headers."),
                              );
                            }

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: prices.length,
                              itemBuilder: (context, index) {
                                final item = prices[index];

                                return ContainerWithCustomizeTextFeild(
                                  itemKey: item.headerKey ?? "",
                                  values: item.value,
                                  ismandatory: item.isDiscount,
                                  itemGstRate: "",
                                  index: index,
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(height: AppDimensions.height10),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      final bookingFormModel = BookingFormModel(
                        customerAadharNumber: bookingFormProvider
                            .bookingFormModel
                            .customerAadharNumber,
                        customerAddress: bookingFormProvider
                            .bookingFormModel
                            .customerAddress,
                        customerDob:
                            bookingFormProvider.bookingFormModel.customerDob,
                        branch:
                            userDetailsProvider.userDetails?.data?.branch ?? "",
                        brokerId: bookingFormProvider.bookingFormModel.brokerId,
                        chassisNumber:
                            bookingFormProvider.bookingFormModel.chassisNumber,
                        modelColor:
                            bookingFormProvider.bookingFormModel.modelColor,
                        customerType:
                            bookingFormProvider.bookingFormModel.customerType,
                        customerDistrict: bookingFormProvider
                            .bookingFormModel
                            .customerDistrict,
                        emiPlan: bookingFormProvider.bookingFormModel.emiPlan,
                        discountValue:
                            bookingFormProvider.bookingFormModel.discountValue,
                        accessoryIds:
                            bookingFormProvider.bookingFormModel.accessoryIds,
                        isExchange:
                            bookingFormProvider.bookingFormModel.isExchange,
                        optionalComponents:
                            selectedModelHeadersProvider.selectedHeaders,
                        exchangePrice:
                            bookingFormProvider.bookingFormModel.exchangePrice,
                        financerId:
                            bookingFormProvider.bookingFormModel.financerId,
                        gcAmount: bookingFormProvider.bookingFormModel.gcAmount,
                        gcApplicable:
                            bookingFormProvider.bookingFormModel.gcApplicable,
                        gstin: bookingFormProvider.bookingFormModel.gstin,
                        hpa: bookingFormProvider.bookingFormModel.hpa,
                        customerMobile1: bookingFormProvider
                            .bookingFormModel
                            .customerMobile1,
                        customerMobile2: bookingFormProvider
                            .bookingFormModel
                            .customerMobile2,
                        modelId: bookingFormProvider.bookingFormModel.modelId,
                        customerName:
                            bookingFormProvider.bookingFormModel.customerName,
                        nomineeAge:
                            bookingFormProvider.bookingFormModel.nomineeAge,
                        nomineeName:
                            bookingFormProvider.bookingFormModel.nomineeName,
                        nomineeRelation: bookingFormProvider
                            .bookingFormModel
                            .nomineeRelation,
                        customerOccupation: bookingFormProvider
                            .bookingFormModel
                            .customerOccupation,
                        paymentType:
                            bookingFormProvider.bookingFormModel.paymentType,
                        customerPincode: bookingFormProvider
                            .bookingFormModel
                            .customerPincode,
                        rtoType: bookingFormProvider.bookingFormModel.rtoType,
                        rtoAmount:
                            bookingFormProvider.bookingFormModel.rtoAmount,
                        saluation:
                            bookingFormProvider.bookingFormModel.saluation,
                        scheme: bookingFormProvider.bookingFormModel.scheme,
                        customerTaluka:
                            bookingFormProvider.bookingFormModel.customerTaluka,
                        vehicleNumber:
                            bookingFormProvider.bookingFormModel.vehicleNumber,
                        customerPanNo:
                            bookingFormProvider.bookingFormModel.customerPanNo,
                        otp: bookingFormProvider.bookingFormModel.otp,
                        salesExecutive:
                            bookingFormProvider.bookingFormModel.salesExecutive,
                        note: bookingFormProvider.bookingFormModel.note,
                      );

                      if (globalKey.currentState!.validate()) {
                        print(bookingFormProvider.bookingFormModel.otp);
                        print(
                          bookingFormProvider.bookingFormModel.salesExecutive,
                        );
                        updateBookingFormProvider.updateBooking(
                          context,
                          widget.bookingId,
                          bookingFormModel,
                        );
                      }
                    },
                    child: TheWidthFullButton(
                      lable: 'Edit Booking',
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
