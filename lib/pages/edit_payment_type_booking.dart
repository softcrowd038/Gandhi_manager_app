// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

class EditPaymentTypeBooking extends StatefulWidget {
  final String? bookingId; // Add bookingId parameter

  const EditPaymentTypeBooking({super.key, required this.bookingId});

  @override
  State<EditPaymentTypeBooking> createState() => _PaymentTypeBookingState();
}

class _PaymentTypeBookingState extends State<EditPaymentTypeBooking> {
  final formKey = GlobalKey<FormState>();

  final paymentTypeController = TextEditingController();
  final financerController = TextEditingController();
  final financeSchemeController = TextEditingController();
  final emiSchemeController = TextEditingController();
  final gcAmountController = TextEditingController();
  final gcApplicableController = TextEditingController();

  String? selectedPaymentType;
  String? selectedGCApplicable;
  String? selectedFinancer;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FinancerProvider>(
        context,
        listen: false,
      ).fetchFinancers(context);

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

        // Populate payment details fields
        setState(() {
          selectedPaymentType = bookingData.payment.type;
          paymentTypeController.text = bookingData.payment.type ?? "FINANCE";
          selectedFinancer = bookingData.payment.financer?.id;
          selectedGCApplicable = bookingData.payment.gcApplicable == true
              ? "Yes"
              : "No";
        });

        // Set controller values
        paymentTypeController.text = selectedPaymentType ?? '';
        financerController.text = bookingData.payment.financer?.name ?? '';
        financeSchemeController.text = bookingData.payment.scheme ?? '';
        emiSchemeController.text = bookingData.payment.emiPlan ?? '';
        gcAmountController.text =
            bookingData.payment.gcAmount?.toString() ?? '';
        gcApplicableController.text = selectedGCApplicable ?? '';

        // Update provider with fetched data
        bookingFormProvider.setPaymentType(bookingData.payment.type ?? "");
        bookingFormProvider.setFinancer(bookingData.payment.financer?.id ?? "");
        bookingFormProvider.setScheme(bookingData.payment.scheme ?? "");
        bookingFormProvider.setEmiDetails(bookingData.payment.emiPlan ?? "");
        bookingFormProvider.setGcApplicable(
          bookingData.payment.gcApplicable ?? false,
        );
        bookingFormProvider.setGcAmount(bookingData.payment.gcAmount ?? 0);

        setState(() {});
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load payment data: $e'),
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
    paymentTypeController.dispose();
    financerController.dispose();
    financeSchemeController.dispose();
    emiSchemeController.dispose();
    gcAmountController.dispose();
    gcApplicableController.dispose();
    super.dispose();
  }

  bool validateForm() {
    if (selectedPaymentType == null || selectedPaymentType!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a payment type'),
          backgroundColor: AppColors.error,
        ),
      );
      return false;
    }
    if (selectedPaymentType == "FINANCE") {
      if (selectedFinancer == null || selectedFinancer!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a financer'),
            backgroundColor: AppColors.error,
          ),
        );
        return false;
      }
    }
    if (selectedPaymentType == "FINANCE") {
      if (selectedGCApplicable == null || selectedGCApplicable!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select Gc is applicable or not'),
            backgroundColor: AppColors.error,
          ),
        );
        return false;
      }
    }
    if (!formKey.currentState!.validate()) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    BookingFormProvider bookingFormProvider = Provider.of<BookingFormProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: StepsAppbarPlain(title: 'Step 5', subtitle: 'Payment Details'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(SizeConfig.screenHeight * 0.01),
                      child: CustomDropDownWithLeadingIcon(
                        setDefault: false,
                        entries: [
                          {"label": "CASH", "value": "CASH"},
                          {"label": "FINANCE", "value": "FINANCE"},
                        ],
                        label: 'Select Payment Type',
                        dropDownEditingController: paymentTypeController,
                        selectedCustomerType: ValueNotifier<String?>(
                          selectedPaymentType,
                        ),
                        hintText: "Select Payment Type",
                        icon: Icons.payment,
                        onSelected: (String? value) {
                          setState(() {
                            selectedPaymentType = value;
                          });
                          bookingFormProvider.setPaymentType(value ?? "");
                          paymentTypeController.text = value ?? '';
                        },
                      ),
                    ),
                    if (selectedPaymentType == "FINANCE") ...[
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.screenHeight * 0.01),
                        child: Consumer<FinancerProvider>(
                          builder: (context, provider, _) {
                            final entries = provider.financeModel?.data;
                            return CustomDropDownWithLeadingIcon(
                              entries: (entries == null || entries.isEmpty)
                                  ? [
                                      {
                                        "label": "No data available",
                                        "value": "",
                                      },
                                    ]
                                  : entries.map<Map<String, String>>((
                                      financer,
                                    ) {
                                      return {
                                        "label": financer.name ?? "",
                                        "value": financer.id ?? "",
                                      };
                                    }).toList(),
                              label: 'Select Financer',
                              dropDownEditingController: financerController,
                              selectedCustomerType: ValueNotifier<String?>(
                                selectedFinancer,
                              ),
                              hintText: 'Select Financer',
                              icon: FontAwesomeIcons.bank,
                              onSelected: (String? value) {
                                setState(() {
                                  selectedFinancer = value;
                                });
                                bookingFormProvider.setFinancer(value ?? "");
                                financerController.text = value ?? '';
                              },
                            );
                          },
                        ),
                      ),
                      CustomTextFieldOutlined(
                        label: "FINANCE Scheme",
                        hintText: "Enter FINANCE Scheme",
                        suffixIcon: FontAwesomeIcons.bank,
                        suffixIconColor: Colors.grey,
                        onChanged: (value) {
                          bookingFormProvider.setScheme(value);
                        },
                        validator: (value) {
                          // if (value == null || value.isEmpty) {
                          //   return 'Please enter finance scheme';
                          // }
                          return null;
                        },
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        controller: financeSchemeController,
                      ),
                      const SizedBox(height: 12),
                      CustomTextFieldOutlined(
                        label: 'EMI Scheme',
                        hintText: '0',
                        suffixIcon: Icons.price_change,
                        suffixIconColor: Colors.black54,
                        obscureText: false,
                        controller: emiSchemeController,
                        validator: (value) {
                          // if (value == null || value.isEmpty) {
                          //   return 'Please enter EMI scheme';
                          // }
                          return null;
                        },
                        onChanged: (value) {
                          bookingFormProvider.setEmiDetails(value);
                        },
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: EdgeInsets.all(SizeConfig.screenHeight * 0.01),
                        child: CustomDropDownWithLeadingIcon(
                          entries: [
                            {"label": "Yes", "value": "Yes"},
                            {"label": "No", "value": "No"},
                          ],
                          label: 'GC Applicable',
                          dropDownEditingController: gcApplicableController,
                          selectedCustomerType: ValueNotifier<String?>(
                            selectedGCApplicable,
                          ),
                          hintText: "Select GC Applicable",
                          icon: FontAwesomeIcons.sackDollar,
                          onSelected: (String? value) {
                            setState(() {
                              selectedGCApplicable = value;
                            });
                            bookingFormProvider.setGcApplicable(
                              value == "Yes" ? true : false,
                            );
                            gcApplicableController.text = value ?? '';
                          },
                        ),
                      ),
                      if (selectedGCApplicable == "Yes" &&
                          bookingFormProvider.bookingFormModel.paymentType ==
                              "FINANCE")
                        CustomTextFieldOutlined(
                          label: "GC Applicable Amount",
                          hintText: "0",
                          suffixIcon: Icons.electric_bike,
                          suffixIconColor: Colors.grey,
                          onChanged: (value) {
                            bookingFormProvider.setGcAmount(
                              int.tryParse(value) ?? 0,
                            );
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter GC applicable amount';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Please enter valid amount';
                            }
                            return null;
                          },
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          controller: gcAmountController,
                        ),
                    ],
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () {
          if (validateForm()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditAccessoriesDetailsBooking(bookingId: widget.bookingId),
              ),
            );
          }
        },
      ),
    );
  }
}
