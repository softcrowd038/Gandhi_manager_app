// ignore_for_file: use_build_context_synchronously, unused_field

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

class ExchangeModeBooking extends StatefulWidget {
  const ExchangeModeBooking({super.key});

  @override
  State<ExchangeModeBooking> createState() => _ExchangeModeBookingState();
}

class _ExchangeModeBookingState extends State<ExchangeModeBooking> {
  final formKey = GlobalKey<FormState>();

  final exchangeModeController = TextEditingController();
  final exchangeBrokerController = TextEditingController();
  final vehicleNumberController = TextEditingController();
  final priceController = TextEditingController();
  final chassisNumberController = TextEditingController();
  final brokerMobileController = TextEditingController();
  final brokerOtpController = TextEditingController();

  String? selectedExchangeMode;
  String? selectedExchangeBroker;
  bool _onClicked = false;
  bool? _isRequired;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final branchId = Provider.of<UserDetailsProvider>(
        context,
        listen: false,
      ).userDetails?.data?.branch;
      Provider.of<ExchangeBrokerProvider>(
        context,
        listen: false,
      ).fetchExchangeBroker(context, branchId ?? "");
      final brokerOtpVerifyProvider = Provider.of<BrokerOtpVerifyProvider>(
        context,
        listen: false,
      );
      brokerOtpVerifyProvider.reset();
      _onClicked = brokerOtpVerifyProvider.onClicked;
    });
  }

  @override
  void dispose() {
    exchangeModeController.dispose();
    exchangeBrokerController.dispose();
    vehicleNumberController.dispose();
    priceController.dispose();
    chassisNumberController.dispose();
    super.dispose();
  }

  bool validateForm() {
    if (selectedExchangeMode == null || selectedExchangeMode!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an exchange mode'),
          backgroundColor: AppColors.error,
        ),
      );
      return false;
    }
    if (selectedExchangeMode == "Yes") {
      if (selectedExchangeBroker == null || selectedExchangeBroker!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an exchange broker'),
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
        title: StepsAppbarPlain(title: 'Step 4', subtitle: 'Exchange Details'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(SizeConfig.screenHeight * 0.01),
                child: CustomDropDownWithLeadingIcon(
                  entries: [
                    {"label": "Yes", "value": "Yes"},
                    {"label": "No", "value": "No"},
                  ],
                  label: 'Select Exchange Mode',
                  dropDownEditingController: exchangeModeController,
                  selectedCustomerType: ValueNotifier<String?>(
                    selectedExchangeMode,
                  ),
                  hintText: "Yes",
                  icon: Icons.recycling,
                  onSelected: (String? value) {
                    setState(() {
                      selectedExchangeMode = value;
                    });
                    bookingFormProvider.setExchange(
                      value == "Yes" ? true : false,
                    );
                    exchangeModeController.text = value ?? '';
                  },
                ),
              ),
              if (selectedExchangeMode == "Yes") ...[
                Padding(
                  padding: EdgeInsets.all(SizeConfig.screenHeight * 0.01),
                  child: Consumer<ExchangeBrokerProvider>(
                    builder: (context, provider, child) {
                      final brokerList = provider.exchangeBrokerModel?.data;

                      final entries = (brokerList == null || brokerList.isEmpty)
                          ? [
                              {"label": "No data available", "value": ""},
                            ]
                          : brokerList.map<Map<String, String>>((broker) {
                              return {
                                "label": broker.name ?? "",
                                "value": broker.id ?? "",
                              };
                            }).toList();

                      return CustomDropDownWithLeadingIcon(
                        entries: entries,
                        label: 'Select Exchange Broker',
                        dropDownEditingController: exchangeBrokerController,
                        selectedCustomerType: ValueNotifier<String?>(
                          selectedExchangeBroker,
                        ),
                        hintText: "Select Exchange Broker",
                        icon: Icons.person,
                        onSelected: (String? value) {
                          setState(() {
                            selectedExchangeBroker = value;
                          });
                          bookingFormProvider.setBroker(value ?? "");
                          exchangeBrokerController.text = value ?? '';
                          final selectedBroker = brokerList?.firstWhere(
                            (broker) => broker.id == value,
                          );

                          if (selectedBroker != null) {
                            brokerMobileController.text =
                                selectedBroker.mobile ?? "";
                            _isRequired = selectedBroker.otpRequired;
                          }
                        },
                      );
                    },
                  ),
                ),
                CustomTextFieldOutlined(
                  label: "Exchange Vehicle Number",
                  hintText: "MH 15 YX 1234",
                  suffixIcon: Icons.electric_bike,
                  suffixIconColor: Colors.grey,
                  onChanged: (value) {
                    bookingFormProvider.setVehicleNumber(value);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter exchange vehicle number';
                    }
                    return null;
                  },
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  controller: vehicleNumberController,
                ),
                const SizedBox(height: 12),
                CustomTextFieldOutlined(
                  label: 'Exchange Price',
                  hintText: '0',
                  suffixIcon: Icons.price_change,
                  suffixIconColor: Colors.black54,
                  obscureText: false,
                  controller: priceController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter exchange price';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    bookingFormProvider.setExchangePrice(
                      int.tryParse(value) ?? 0,
                    );
                  },
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                CustomTextFieldOutlined(
                  label: 'Exchange Chassis no.',
                  hintText: 'Enter exchange chassis no.',
                  suffixIcon: Icons.numbers,
                  suffixIconColor: Colors.black54,
                  obscureText: false,
                  controller: chassisNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter exchange chassis no.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    bookingFormProvider.setChassisNumber(value);
                  },
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 12),
                _isRequired ?? false
                    ? Consumer<BrokerOtpVerifyProvider>(
                        builder: (context, brokerOtpVerifyProvider, child) {
                          final onClicked = brokerOtpVerifyProvider.onClicked;
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 2,
                                child: CustomTextFieldOutlined(
                                  label: 'Broker Mobile',
                                  hintText: 'Enter broker mobile no.',
                                  suffixIcon: Icons.phone,
                                  suffixIconColor: Colors.black54,
                                  obscureText: false,
                                  controller: brokerMobileController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter broker mobile no.';
                                    }
                                    if (value.length != 10) {
                                      return 'Enter valid 10-digit mobile number';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) {},
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.008,
                                ),
                                child: GestureDetector(
                                  onTap: !onClicked
                                      ? () {
                                          brokerOtpVerifyProvider
                                              .postOtpBrokerVerification(
                                                context,
                                              );
                                        }
                                      : null,
                                  child: Container(
                                    height: AppDimensions.height6,
                                    width: AppDimensions.width25,
                                    decoration: BoxDecoration(
                                      color: !onClicked
                                          ? AppColors.primary
                                          : AppColors.textSecondary,
                                    ),
                                    child: Center(
                                      child: brokerOtpVerifyProvider.isLoading
                                          ? const CircularProgressIndicator(
                                              color: Colors.white,
                                            )
                                          : Text(
                                              "Send OTP",
                                              style: TextStyle(
                                                fontSize: AppFontSize.s16,
                                                color: Colors.white,
                                                fontWeight: AppFontWeight.w600,
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      )
                    : const SizedBox.shrink(),
                Consumer<BrokerOtpVerifyProvider>(
                  builder: (context, brokerOtpVerifyProvider, child) {
                    return _isRequired ?? false
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                flex: 2,
                                child: CustomTextFieldOutlined(
                                  label: 'OTP',
                                  hintText: 'Enter OTP here',
                                  suffixIcon: Icons.phone,
                                  suffixIconColor: Colors.black54,
                                  obscureText: false,
                                  controller: brokerOtpController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter otp';
                                    }
                                    if (value.length != 6) {
                                      return 'Enter valid 6 digit otp';
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) {},
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.008,
                                ),
                                child: Consumer<BrokerOtpVerificationProvider>(
                                  builder: (context, brokerVerificationProvider, _) {
                                    return GestureDetector(
                                      onTap:
                                          brokerOtpVerifyProvider.onClicked ==
                                              true
                                          ? () async {
                                              final otpProvider =
                                                  Provider.of<
                                                    BrokerOtpVerificationProvider
                                                  >(context, listen: false);
                                              final success = await otpProvider
                                                  .verifyOtp(
                                                    brokerOtpController.text,
                                                    context,
                                                  );

                                              if (!mounted) return;
                                              if (success) {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      "OTP Verified Successfully",
                                                    ),
                                                    backgroundColor:
                                                        Colors.green,
                                                  ),
                                                );
                                                bookingFormProvider.setOtp(
                                                  brokerOtpController.text,
                                                );
                                                Provider.of<
                                                      BrokerOtpVerifyProvider
                                                    >(context, listen: false)
                                                    .reset();
                                              } else {
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      otpProvider
                                                              .errorMessage ??
                                                          "Verification failed",
                                                    ),
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                  ),
                                                );
                                              }
                                            }
                                          : () {},
                                      child: Container(
                                        height: AppDimensions.height6,
                                        width: AppDimensions.width25,
                                        decoration: BoxDecoration(
                                          color:
                                              brokerOtpVerifyProvider
                                                      .onClicked ==
                                                  false
                                              ? AppColors.textSecondary
                                              : AppColors.success,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Verify",
                                            style: TextStyle(
                                              fontSize: AppFontSize.s16,
                                              color: Colors.white,
                                              fontWeight: AppFontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )
                        : const SizedBox.shrink();
                  },
                ),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () {
          if (validateForm()) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PaymentTypeBooking()),
            );
          }
        },
      ),
    );
  }
}
