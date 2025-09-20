// ignore_for_file: unused_field, use_build_context_synchronously, avoid_print

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

class EditExchangeModeBooking extends StatefulWidget {
  final String? bookingId; // Add bookingId parameter

  const EditExchangeModeBooking({super.key, required this.bookingId});

  @override
  State<EditExchangeModeBooking> createState() => _ExchangeModeBookingState();
}

class _ExchangeModeBookingState extends State<EditExchangeModeBooking> {
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
  bool? _isRequired;
  bool? _otpVerified;
  bool _isLoading = false;
  bool _isInitialDataLoaded = false;
  bool _showOtpFields = false; // Added to control OTP fields visibility

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
      Provider.of<BrokerOtpVerifyProvider>(context, listen: false);

      // Fetch booking data if bookingId is provided
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

        // Populate exchange details fields
        setState(() {
          selectedExchangeMode = bookingData.exchange == true ? "Yes" : "No";
          selectedExchangeBroker = bookingData.exchangeDetails.broker.id;
          _otpVerified = bookingData.exchangeDetails.otpVerified;
          _showOtpFields =
              bookingData.exchangeDetails.price != null &&
              bookingData.exchangeDetails.price! > 0;
        });

        // Set controller values
        exchangeModeController.text = selectedExchangeMode ?? '';
        exchangeBrokerController.text =
            bookingData.exchangeDetails.broker.name ?? '';
        vehicleNumberController.text =
            bookingData.exchangeDetails.vehicleNumber ?? '';
        priceController.text = bookingData.exchangeDetails.price.toString();
        chassisNumberController.text =
            bookingData.exchangeDetails.chassisNumber ?? '';

        // Update provider with fetched data
        bookingFormProvider.setExchange(bookingData.exchange ?? false);
        bookingFormProvider.setBroker(
          bookingData.exchangeDetails.broker.id ?? "",
        );
        bookingFormProvider.setVehicleNumber(
          bookingData.exchangeDetails.vehicleNumber ?? "",
        );
        bookingFormProvider.setExchangePrice(
          bookingData.exchangeDetails.price ?? 0,
        );
        bookingFormProvider.setChassisNumber(
          bookingData.exchangeDetails.chassisNumber ?? "",
        );

        setState(() {
          _isInitialDataLoaded = true;
        });
      }
    } catch (e) {
      print('Error fetching booking data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load exchange data: $e'),
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
    exchangeModeController.dispose();
    exchangeBrokerController.dispose();
    vehicleNumberController.dispose();
    priceController.dispose();
    chassisNumberController.dispose();
    brokerMobileController.dispose();
    brokerOtpController.dispose();
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
      if (_showOtpFields && (_isRequired ?? false)) {
        if (brokerMobileController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please enter broker mobile number'),
              backgroundColor: AppColors.error,
            ),
          );
          return false;
        }
        if (brokerOtpController.text.isEmpty && !(_otpVerified ?? false)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please enter OTP for verification'),
              backgroundColor: AppColors.error,
            ),
          );
          return false;
        }
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Consumer<GetBookingsByIdProvider>(
                builder: (context, getBookingByIdProvider, _) {
                  return Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(
                            SizeConfig.screenHeight * 0.01,
                          ),
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
                                _showOtpFields =
                                    value == "Yes" &&
                                    (int.tryParse(priceController.text) ?? 0) >
                                        0;
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
                            padding: EdgeInsets.all(
                              SizeConfig.screenHeight * 0.01,
                            ),
                            child: Consumer<ExchangeBrokerProvider>(
                              builder: (context, provider, child) {
                                final brokerList =
                                    provider.exchangeBrokerModel?.data;

                                final entries =
                                    (brokerList == null || brokerList.isEmpty)
                                    ? [
                                        {
                                          "label": "No data available",
                                          "value": "",
                                        },
                                      ]
                                    : brokerList.map<Map<String, String>>((
                                        broker,
                                      ) {
                                        return {
                                          "label": broker.name ?? "",
                                          "value": broker.id ?? "",
                                        };
                                      }).toList();

                                return CustomDropDownWithLeadingIcon(
                                  entries: entries,
                                  label: 'Select Exchange Broker',
                                  dropDownEditingController:
                                      exchangeBrokerController,
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
                                    final selectedBroker = brokerList
                                        ?.firstWhere(
                                          (broker) => broker.id == value,
                                          orElse: () => brokerList.first,
                                        );

                                    // if (selectedBroker != null) {
                                    //   brokerMobileController.text =
                                    //       selectedBroker.mobile ?? "";
                                    //   _isRequired = selectedBroker.otpRequired;
                                    //   setState(() {
                                    //     _showOtpFields = true;
                                    //   });
                                    // }

                                    if (selectedBroker != null) {
                                      brokerMobileController.text =
                                          selectedBroker.mobile ?? "";
                                      _isRequired = selectedBroker.otpRequired;
                                      // Show OTP fields if price is already set
                                      if ((int.tryParse(priceController.text) ??
                                              0) >
                                          0) {
                                        setState(() {
                                          _showOtpFields = true;
                                        });
                                      }
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
                              final price = int.tryParse(value) ?? 0;
                              _isRequired = true;
                              bookingFormProvider.setExchangePrice(price);

                              // Show OTP fields when price is changed to a positive value
                              setState(() {
                                _showOtpFields = price > 0;
                              });
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

                          if (_showOtpFields && (_isRequired ?? false)) ...[
                            Consumer<BrokerOtpVerifyProvider>(
                              builder: (context, brokerOtpVerifyProvider, child) {
                                final onClicked =
                                    brokerOtpVerifyProvider.onClicked;
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
                                            MediaQuery.of(context).size.width *
                                            0.008,
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
                                            child:
                                                brokerOtpVerifyProvider
                                                    .isLoading
                                                ? const CircularProgressIndicator(
                                                    color: Colors.white,
                                                  )
                                                : Text(
                                                    "Send OTP",
                                                    style: TextStyle(
                                                      fontSize: AppFontSize.s16,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          AppFontWeight.w600,
                                                    ),
                                                  ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 12),
                            Consumer<BrokerOtpVerifyProvider>(
                              builder: (context, brokerOtpVerifyProvider, child) {
                                return Row(
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
                                            MediaQuery.of(context).size.width *
                                            0.008,
                                      ),
                                      child: Consumer<BrokerOtpVerificationProvider>(
                                        builder: (context, brokerVerificationProvider, _) {
                                          return GestureDetector(
                                            onTap:
                                                brokerOtpVerifyProvider
                                                        .onClicked ==
                                                    true
                                                ? () async {
                                                    final otpProvider =
                                                        Provider.of<
                                                          BrokerOtpVerificationProvider
                                                        >(
                                                          context,
                                                          listen: false,
                                                        );
                                                    final success =
                                                        await otpProvider
                                                            .verifyOtp(
                                                              brokerOtpController
                                                                  .text,
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
                                                      bookingFormProvider
                                                          .setOtp(
                                                            brokerOtpController
                                                                .text,
                                                          );
                                                      Provider.of<
                                                            BrokerOtpVerifyProvider
                                                          >(
                                                            context,
                                                            listen: false,
                                                          )
                                                          .reset();
                                                      setState(() {
                                                        _otpVerified = true;
                                                      });
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
                                                : null,
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
                                                    fontWeight:
                                                        AppFontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 12),
                          ],
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () {
          if (validateForm()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EditPaymentTypeBooking(bookingId: widget.bookingId),
              ),
            );
          }
        },
      ),
    );
  }
}
