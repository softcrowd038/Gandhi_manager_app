import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_bookings_model.dart';
import 'package:gandhi_tvs/models/downpayment_model.dart';
import 'package:gandhi_tvs/provider/downpayment_provider.dart';
import 'package:provider/provider.dart';

class AddDownpaymentPage extends HookWidget {
  const AddDownpaymentPage({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final financeDisbursmentController = useTextEditingController();
    final downpaymentController = useTextEditingController();
    final dealAmountController = useTextEditingController();
    final deviationController = useTextEditingController();
    final globalKey = useMemoized(() => GlobalKey<FormState>());
    final downPaymentProvider = Provider.of<DownpaymentProvider>(
      context,
      listen: false,
    );

    final isConfirmed = useState<bool>(false);
    final formErrors = useState<Map<String, String?>>({});

    void calculateDownpayment() {
      final dealAmount = int.tryParse(dealAmountController.text) ?? 0;
      final financeAmt = int.tryParse(financeDisbursmentController.text) ?? 0;

      final downpayment = dealAmount - financeAmt;
      downpaymentController.text = downpayment.toString();

      // Update provider with calculated values
      downPaymentProvider.setDisbursementAmount(financeAmt);
      downPaymentProvider.setDownPaymentExpected(downpayment);
    }

    String? validateNumber(String? value, String fieldName) {
      if (value == null || value.isEmpty) {
        return '$fieldName is required';
      }
      if (int.tryParse(value) == null) {
        return 'Please enter a valid number';
      }
      return null;
    }

    bool validateForm() {
      final errors = <String, String?>{};

      errors['dealAmount'] = validateNumber(
        dealAmountController.text,
        'Deal Amount',
      );
      errors['finance'] = validateNumber(
        financeDisbursmentController.text,
        'Finance Disbursement Amount',
      );
      errors['downpayment'] = validateNumber(
        downpaymentController.text,
        'Downpayment',
      );

      if (isConfirmed.value) {
        errors['deviation'] = validateNumber(
          deviationController.text,
          'Deviation Amount',
        );
      }

      formErrors.value = errors;

      return errors.values.every((error) => error == null);
    }

    void submitDownpayment() {
      if (!validateForm()) {
        return;
      }

      try {
        DownpaymentModel downpaymentModel = DownpaymentModel(
          bookingId: booking.id ?? "",
          disbursementAmount: int.parse(financeDisbursmentController.text),
          downPaymentExpected: int.parse(downpaymentController.text),
          isDeviation: isConfirmed.value,
        );

        downPaymentProvider.postDownpayment(context, downpaymentModel);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        dealAmountController.text = booking.discountedAmount?.toString() ?? "0";
        downPaymentProvider.setBookingId(booking.id ?? "");
      });

      financeDisbursmentController.addListener(calculateDownpayment);

      return () {
        financeDisbursmentController.removeListener(calculateDownpayment);
      };
    }, []);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        title: const Text("Add Downpayment"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Consumer<UserDetailsProvider>(
            builder: (context, userDetails, _) {
              final deviationLimit =
                  userDetails.userDetails?.data?.perTransactionDeviationLimit ??
                  0;
              deviationController.text = deviationLimit.toString();

              return Form(
                key: globalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomerHeader(
                      customerName:
                          "${booking.customerDetails.salutation} ${booking.customerDetails.name}",
                      address: booking.model.modelName,
                      bookingId: booking.bookingNumber ?? "",
                    ),
                    const Divider(),
                    SectionTitle(title: "Add Downpayment Details"),

                    /// Deal Amount
                    Padding(
                      padding: AppPadding.p2,
                      child: OutlinedBorderTextfieldWidget(
                        label: "Deal Amount",
                        hintText: "xxxx",
                        suffixIcon: Icons.currency_rupee,
                        suffixIconColor: Colors.grey,
                        controller: dealAmountController,
                        validator: (value) =>
                            validateNumber(value, 'Deal Amount'),

                        obscureText: false,
                        keyboardType: TextInputType.number,
                        readOnly: true,
                        onChanged: (String) {},
                      ),
                    ),

                    /// Finance Disbursement Amount
                    Padding(
                      padding: AppPadding.p2,
                      child: OutlinedBorderTextfieldWidget(
                        label: "Finance Disbursement Amount",
                        hintText: "xxxx",
                        suffixIcon: Icons.currency_rupee,
                        suffixIconColor: Colors.grey,
                        controller: financeDisbursmentController,
                        validator: (value) => validateNumber(
                          value,
                          'Finance Disbursement Amount',
                        ),

                        obscureText: false,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          final amount = int.tryParse(value) ?? 0;
                          downPaymentProvider.setDisbursementAmount(amount);
                        },
                      ),
                    ),

                    /// Downpayment
                    Padding(
                      padding: AppPadding.p2,
                      child: OutlinedBorderTextfieldWidget(
                        label: "Downpayment",
                        hintText: "xxxx",
                        suffixIcon: Icons.currency_rupee,
                        suffixIconColor: Colors.grey,
                        controller: downpaymentController,
                        validator: (value) =>
                            validateNumber(value, 'Downpayment'),

                        obscureText: false,
                        keyboardType: TextInputType.number,
                        readOnly: true,
                        onChanged:
                            (
                              String,
                            ) {}, // Make it read-only since it's calculated
                      ),
                    ),

                    SwitchListTile(
                      title: const Text("Confirm Deviation"),
                      value: isConfirmed.value,
                      onChanged: (val) {
                        isConfirmed.value = val;
                        calculateDownpayment();
                        downPaymentProvider.setIsDeviation(isConfirmed.value);
                      },
                      activeColor: Theme.of(context).primaryColor,
                    ),

                    if (isConfirmed.value)
                      Padding(
                        padding: AppPadding.p2,
                        child: OutlinedBorderTextfieldWidget(
                          label: "Deviation Amount",
                          hintText: "xxxx",
                          suffixIcon: Icons.currency_rupee,
                          suffixIconColor: Colors.grey,
                          controller: deviationController,
                          validator: (value) =>
                              validateNumber(value, 'Deviation Amount'),

                          obscureText: false,
                          keyboardType: TextInputType.number,
                          readOnly: true,
                          onChanged: (String) {},
                        ),
                      ),

                    const SizedBox(height: 24),

                    Padding(
                      padding: AppPadding.p2,
                      child: GestureDetector(
                        onTap: submitDownpayment,
                        child: Container(
                          height: AppDimensions.height6,
                          width: AppDimensions.fullWidth,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                          ),
                          child: Center(
                            child: Text(
                              "SUBMIT",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AppFontSize.s18,
                                fontWeight: AppFontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
