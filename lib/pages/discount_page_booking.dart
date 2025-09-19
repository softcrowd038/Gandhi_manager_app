// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

class DiscountPageBooking extends HookWidget {
  const DiscountPageBooking({super.key});

  @override
  Widget build(BuildContext context) {
    final discountController = useTextEditingController();
    final noteController = useTextEditingController();
    BookingFormProvider bookingFormProvider = Provider.of<BookingFormProvider>(
      context,
      listen: false,
    );
    UserDetailsProvider userDetailsProvider = Provider.of<UserDetailsProvider>(
      context,
      listen: false,
    );
    SelectedModelHeadersProvider selectedModelHeadersProvider =
        Provider.of<SelectedModelHeadersProvider>(context, listen: false);
    GlobalKey<FormState> globalKey = GlobalKey();

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final selectedModelsProvider = Provider.of<SelectedModelsProvider>(
          context,
          listen: false,
        );
        final modelId = selectedModelsProvider.selectedModels.first.id;
        final modelHeadersProvider = Provider.of<ModelHeadersProvider>(
          context,
          listen: false,
        );

        await modelHeadersProvider.fetchModelHeaders(context, modelId);

        // final userProvider = Provider.of<UserDetailsProvider>(
        //   context,
        //   listen: false,
        // );
        // userProvider.fetchUserDetails(context);
      });
      return null;
    }, []);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: StepsAppbarPlain(title: "Final Steps", subtitle: "Add Discount"),
      ),
      body: Stack(
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
                        bookingFormProvider.setDiscount(int.parse(value));
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Discount';
                        }
                        return null;
                      },
                      obscureText: false,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: AppPadding.p2,
                    child: OutlinedBorderTextfieldWidget(
                      label: "Note",
                      hintText: "Add note here",
                      suffixIcon: Icons.note,
                      suffixIconColor: Colors.grey,
                      controller: noteController,
                      onChanged: (value) {
                        bookingFormProvider.setNote(noteController.text);
                      },
                      validator: (value) {
                        return;
                      },
                      obscureText: false,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  Padding(
                    padding: AppPadding.p2,
                    child: Consumer<ModelHeadersProvider>(
                      builder: (context, modelHeadersProvider, _) {
                        final totalAmount = modelHeadersProvider
                            .modelHeaders
                            ?.data
                            ?.model
                            .prices
                            .where((item) {
                              final headerKey =
                                  item.headerKey?.toLowerCase() ?? '';
                              return !headerKey.contains('on road') &&
                                  !headerKey.contains('+') &&
                                  !headerKey.contains('total');
                            })
                            .fold<double>(
                              0.0,
                              (sum, item) =>
                                  sum + (item.value?.toDouble() ?? 0.0),
                            );
                        // final discountText = discountController.text.trim();
                        // double discountValue = 0.0;

                        // try {
                        //   if (discountText.isNotEmpty) {
                        //     discountValue = double.parse(discountText);
                        //   }
                        // } catch (e) {
                        //   discountValue = 0.0;

                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(content: Text('Invalid discount amount')),
                        //   );
                        // }

                        // final discountedAmount =
                        //     (totalAmount ?? 0.0) - discountValue;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Amount:",
                                  style: TextStyle(
                                    fontWeight: AppFontWeight.bold,
                                    fontSize: AppFontSize.s18,
                                  ),
                                ),
                                Text(
                                  '${totalAmount.toString()} Rs.',
                                  style: TextStyle(
                                    fontWeight: AppFontWeight.w500,
                                    fontSize: AppFontSize.s18,
                                    color: AppColors.success,
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //   children: [
                            //     Text(
                            //       "Discounted Amount:",
                            //       style: TextStyle(
                            //         fontWeight: AppFontWeight.bold,
                            //         fontSize: AppFontSize.s18,
                            //       ),
                            //     ),
                            //     Text(
                            //       discountedAmount.toString(),
                            //       style: TextStyle(
                            //         fontWeight: AppFontWeight.bold,
                            //         fontSize: AppFontSize.s18,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        );
                      },
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
                      final prices = value.modelHeaders?.data?.model.prices;

                      if (prices == null) {
                        return const Center(child: CircularProgressIndicator());
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
            child: SafeArea(
              bottom: true,
              minimum: AppPadding.p2,
              child: GestureDetector(
                onTap: () {
                  final bookingFormModel = BookingFormModel(
                    customerAadharNumber: bookingFormProvider
                        .bookingFormModel
                        .customerAadharNumber,
                    customerAddress:
                        bookingFormProvider.bookingFormModel.customerAddress,
                    customerDob:
                        bookingFormProvider.bookingFormModel.customerDob,
                    branch: userDetailsProvider.userDetails?.data?.branch ?? "",
                    brokerId: bookingFormProvider.bookingFormModel.brokerId,
                    chassisNumber:
                        bookingFormProvider.bookingFormModel.chassisNumber,
                    modelColor: bookingFormProvider.bookingFormModel.modelColor,
                    customerType:
                        bookingFormProvider.bookingFormModel.customerType,
                    customerDistrict:
                        bookingFormProvider.bookingFormModel.customerDistrict,
                    emiPlan: bookingFormProvider.bookingFormModel.emiPlan,
                    discountValue:
                        bookingFormProvider.bookingFormModel.discountValue,
                    accessoryIds:
                        bookingFormProvider.bookingFormModel.accessoryIds,
                    isExchange: bookingFormProvider.bookingFormModel.isExchange,
                    optionalComponents:
                        selectedModelHeadersProvider.selectedHeaders,
                    exchangePrice:
                        bookingFormProvider.bookingFormModel.exchangePrice,
                    financerId: bookingFormProvider.bookingFormModel.financerId,
                    gcAmount: bookingFormProvider.bookingFormModel.gcAmount,
                    gcApplicable:
                        bookingFormProvider.bookingFormModel.gcApplicable,
                    gstin: bookingFormProvider.bookingFormModel.gstin,
                    hpa: bookingFormProvider.bookingFormModel.hpa,
                    customerMobile1:
                        bookingFormProvider.bookingFormModel.customerMobile1,
                    customerMobile2:
                        bookingFormProvider.bookingFormModel.customerMobile2,
                    modelId: bookingFormProvider.bookingFormModel.modelId,
                    customerName:
                        bookingFormProvider.bookingFormModel.customerName,
                    nomineeAge: bookingFormProvider.bookingFormModel.nomineeAge,
                    nomineeName:
                        bookingFormProvider.bookingFormModel.nomineeName,
                    nomineeRelation:
                        bookingFormProvider.bookingFormModel.nomineeRelation,
                    customerOccupation:
                        bookingFormProvider.bookingFormModel.customerOccupation,
                    paymentType:
                        bookingFormProvider.bookingFormModel.paymentType,
                    customerPincode:
                        bookingFormProvider.bookingFormModel.customerPincode,
                    rtoType: bookingFormProvider.bookingFormModel.rtoType,
                    rtoAmount: bookingFormProvider.bookingFormModel.rtoAmount,
                    saluation: bookingFormProvider.bookingFormModel.saluation,
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
                    bookingFormProvider.postBookingForm(
                      context,
                      bookingFormModel,
                    );
                  }
                },
                child: TheWidthFullButton(
                  lable: 'APPLY FOR APPROVAL',
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
