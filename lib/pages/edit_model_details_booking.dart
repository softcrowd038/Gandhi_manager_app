// ignore_for_file: deprecated_member_use

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/provider/get_all_users_provider.dart';
import 'package:provider/provider.dart';

class EditModelDetailsBooking extends StatefulWidget {
  final String? bookingId;
  const EditModelDetailsBooking({super.key, required this.bookingId});

  @override
  State<EditModelDetailsBooking> createState() => _ModelDetailsBookingState();
}

class _ModelDetailsBookingState extends State<EditModelDetailsBooking> {
  final colorEditingController = TextEditingController();
  final rtoTypeEditingController = TextEditingController();
  final rtoAmountEditingController = TextEditingController();
  final hpaEditingController = TextEditingController();
  final salesExecutiveController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  String? selectedColor;
  String? selectedRtoType;
  String? selectedHPA;
  List<bool> selectedAccessories = [];
  String? selectedSalesExecuative;
  String? branch;
  String? roleName;
  bool _isInitialDataLoaded = false;
  bool _isLoading = false;
  List<String> _selectedAccessoryIds = [];

  Future<void> getUserBranch() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    branch = sharedPreferences.getString('branch');
    roleName = sharedPreferences.getString('role_name');
  }

  @override
  void initState() {
    super.initState();
    getUserBranch().then((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final selectedModelsProvider = Provider.of<SelectedModelsProvider>(
          context,
          listen: false,
        );
        final modelId = selectedModelsProvider.selectedModels.first.id;
        final colorsProvider = Provider.of<ColorsProvider>(
          context,
          listen: false,
        );
        colorsProvider.fetchBikeModelsColor(context, modelId ?? "");

        final usersProvider = roleName == "MANAGER"
            ? Provider.of<GetAllUsersProvider>(context, listen: false)
            : null;

        roleName == "MANAGER"
            ? usersProvider?.getAllUsersProvider(context)
            : null;

        final modelHeadersProvider = Provider.of<ModelHeadersProvider>(
          context,
          listen: false,
        );
        modelHeadersProvider.fetchModelHeaders(context, modelId ?? "");

        if (widget.bookingId != null) {
          _fetchBookingData();
        }
      });
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

        setState(() {
          selectedColor = bookingData.color?.id;
          colorEditingController.text = bookingData.color?.name ?? '';
          selectedRtoType = bookingData.rto;
          rtoTypeEditingController.text = bookingData.rto ?? '';
          selectedHPA = bookingData.hpa == true ? 'yes' : 'no';
          hpaEditingController.text = selectedHPA!;
          selectedSalesExecuative = bookingData.salesExecutive?.id;
          salesExecutiveController.text =
              bookingData.salesExecutive?.name ?? '';
        });

        bookingFormProvider.setColor(bookingData.color?.id ?? "");
        bookingFormProvider.setRto(bookingData.rto ?? "");

        if (bookingData.rtoAmount != null) {
          rtoAmountEditingController.text = bookingData.rtoAmount.toString();
          bookingFormProvider.setRtoAmount(bookingData.rtoAmount ?? 0);
        }

        bookingFormProvider.setHpa(bookingData.hpa ?? false);
        bookingFormProvider.setSalesExecuative(
          bookingData.salesExecutive?.id ?? "",
        );

        _setSelectedAccessories(bookingData.accessories ?? []);

        setState(() {
          _isInitialDataLoaded = true;
        });
      }
    } catch (e) {
      print('Error fetching booking data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load booking data: $e'),
          backgroundColor: AppColors.error,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _setSelectedAccessories(List<dynamic> accessories) {
    _selectedAccessoryIds = accessories
        .map((accessory) {
          return accessory['id']?.toString() ??
              accessory['headerId']?.toString() ??
              '';
        })
        .where((id) => id.isNotEmpty)
        .toList();

    // Also update the BookingFormProvider
    final bookingFormProvider = Provider.of<BookingFormProvider>(
      context,
      listen: false,
    );

    // Assuming your BookingFormProvider has a method to set accessories
    // If not, you'll need to add it
    bookingFormProvider.setAccessories(_selectedAccessoryIds);

    print('Selected accessory IDs: $_selectedAccessoryIds');
  }

  // Helper method to check if an accessory is selected
  bool _isAccessorySelected(String accessoryId) {
    return _selectedAccessoryIds.contains(accessoryId);
  }

  @override
  void dispose() {
    colorEditingController.dispose();
    rtoTypeEditingController.dispose();
    rtoAmountEditingController.dispose();
    hpaEditingController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    if (selectedColor == null || selectedColor!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a color'),
          backgroundColor: AppColors.error,
        ),
      );
      return false;
    }
    if (selectedRtoType == null || selectedRtoType!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an RTO type'),
          backgroundColor: AppColors.error,
        ),
      );
      return false;
    }
    if (selectedHPA == null || selectedHPA!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select HPA status'),
          backgroundColor: AppColors.error,
        ),
      );
      return false;
    }
    if (!globalKey.currentState!.validate()) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final bookingFormProvider = Provider.of<BookingFormProvider>(
      context,
      listen: false,
    );

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        title: StepsAppbarPlain(
          title: 'Step 2',
          subtitle: widget.bookingId != null
              ? 'Edit Model Details'
              : 'Model Details',
        ),
        backgroundColor: AppColors.surface,
      ),
      body: Consumer2<UserDetailsProvider, GetBookingsByIdProvider>(
        builder: (context, user, bookingByIdProvider, _) {
          // Show loading state
          if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Show error state
          if (widget.bookingId != null &&
              bookingByIdProvider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${bookingByIdProvider.errorMessage}',
                    style: TextStyle(color: Colors.red),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _fetchBookingData,
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
            child: Form(
              key: globalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Consumer<ColorsProvider>(
                    builder: (context, colorsProvider, _) {
                      final colorList =
                          colorsProvider.colorModels?.data?.colors;

                      final entries = (colorList == null || colorList.isEmpty)
                          ? [
                              {"label": "No data available", "value": ""},
                            ]
                          : colorList.map<Map<String, String>>((color) {
                              return {
                                "label": color.name ?? "",
                                "value": color.id ?? "",
                              };
                            }).toList();

                      return CustomDropDownWithLeadingIcon(
                        setDefault: false,
                        dropDownEditingController: colorEditingController,
                        selectedCustomerType: ValueNotifier<String?>(
                          selectedColor,
                        ),
                        entries: entries,
                        hintText: "Select Color",
                        label: "Model Color",
                        icon: Icons.circle_outlined,
                        onSelected: (String? value) {
                          bookingFormProvider.setColor(value ?? "");
                          setState(() {
                            selectedColor = value;
                          });
                          colorEditingController.text = value ?? '';
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomDropDownWithLeadingIcon(
                    setDefault: false,
                    dropDownEditingController: rtoTypeEditingController,
                    selectedCustomerType: ValueNotifier<String?>(
                      selectedRtoType,
                    ),
                    entries: [
                      {"label": "MH", "value": "MH"},
                      {"label": "BH", "value": "BH"},
                      {"label": "CRTM", "value": "CRTM"},
                    ],
                    hintText: 'Select Type',
                    label: 'RTO Type',
                    icon: FontAwesomeIcons.cross,
                    onSelected: (String? value) {
                      bookingFormProvider.setRto(value ?? "");
                      setState(() {
                        selectedRtoType = value;
                      });
                      rtoTypeEditingController.text = value ?? '';
                    },
                  ),
                  const SizedBox(height: 16),
                  if (selectedRtoType == 'BH' || selectedRtoType == 'CRTM')
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: SizeConfig.screenHeight * 0.016,
                      ),
                      child: CustomTextFieldOutlined(
                        controller: rtoAmountEditingController,
                        hintText: 'Enter RTO Amount',
                        obscureText: false,
                        suffixIcon: FontAwesomeIcons.trafficLight,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter RTO amount';
                          }
                          return null;
                        },
                        label: 'RTO Amount',
                        onChanged: (value) {
                          bookingFormProvider.setRtoAmount(int.parse(value));
                        },
                        keyboardType: TextInputType.number,
                        suffixIconColor: Colors.black,
                      ),
                    ),
                  CustomDropDownWithLeadingIcon(
                    setDefault: false,
                    dropDownEditingController: hpaEditingController,
                    selectedCustomerType: ValueNotifier<String?>(selectedHPA),
                    entries: [
                      {"label": "yes", "value": "yes"},
                      {"label": "no", "value": "no"},
                    ],
                    hintText: 'Select Status',
                    label: 'HPA',
                    icon: FontAwesomeIcons.bank,
                    onSelected: (String? value) {
                      value == 'yes'
                          ? bookingFormProvider.setHpa(true)
                          : bookingFormProvider.setHpa(false);
                      setState(() {
                        selectedHPA = value;
                      });
                      hpaEditingController.text = value ?? '';
                    },
                  ),
                  const SizedBox(height: 16),
                  user.userDetails?.data?.roles.any(
                            (role) => role.name == 'MANAGER',
                          ) ??
                          true
                      ? Consumer<GetAllUsersProvider>(
                          builder: (context, allUsers, _) {
                            final salesExecuativeList =
                                allUsers.allUsersModel?.data;

                            final activeSalesExecutives = salesExecuativeList
                                ?.where((user) {
                                  final isActive = user.isFrozen == false;
                                  final hasSalesExecutiveRole = user.roles.any(
                                    (role) => role.name == 'SALES_EXECUTIVE',
                                  );
                                  final isUserActive = user.status == "ACTIVE";
                                  final isBranchAssociated =
                                      user.branch == branch;
                                  return isActive &&
                                      hasSalesExecutiveRole &&
                                      isBranchAssociated &&
                                      isUserActive;
                                })
                                .toList();

                            final entries =
                                (activeSalesExecutives == null ||
                                    activeSalesExecutives.isEmpty)
                                ? [
                                    {
                                      "label":
                                          "No active sales executives available",
                                      "value": "",
                                    },
                                  ]
                                : activeSalesExecutives
                                      .map<Map<String, String>>((user) {
                                        return {
                                          "label": user.name ?? "Unnamed",
                                          "value": user.id ?? "",
                                        };
                                      })
                                      .toList();

                            return CustomDropDownWithLeadingIcon(
                              setDefault: false,
                              dropDownEditingController:
                                  salesExecutiveController,
                              selectedCustomerType: ValueNotifier<String?>(
                                selectedSalesExecuative,
                              ),
                              entries: entries,
                              hintText: "Select Sales executive",
                              label: "Sales executive",
                              icon: Icons.person,
                              onSelected: (String? value) {
                                bookingFormProvider.setSalesExecuative(
                                  value ?? "",
                                );
                                setState(() {
                                  selectedSalesExecuative = value;
                                });
                                salesExecutiveController.text = value ?? '';
                              },
                            );
                          },
                        )
                      : SizedBox.shrink(),
                  const SizedBox(height: 16),
                  Text(
                    'Facilities',
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.018,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.45,
                    child: Consumer<ModelHeadersProvider>(
                      builder: (context, modelHeader, _) {
                        if (modelHeader.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (modelHeader.errorMessage != null) {
                          return Center(
                            child: Text('Error: ${modelHeader.errorMessage}'),
                          );
                        }

                        final prices =
                            modelHeader.modelHeaders?.data?.model.prices ?? [];

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (selectedAccessories.length != prices.length) {
                            setState(() {
                              selectedAccessories = List<bool>.filled(
                                prices.length,
                                false,
                              );
                            });
                          }
                        });

                        if (prices.isEmpty) {
                          return const Center(
                            child: Text('No facilities available'),
                          );
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: prices.length,
                          itemBuilder: (BuildContext context, int index) {
                            final accessory = prices[index];
                            final isSelected = _isAccessorySelected(
                              accessory.headerId ?? '',
                            );

                            return ItemSelectionContainer(
                              accessory: accessory.headerKey ?? '',
                              isMandatory: accessory.isMandatory ?? false,
                              accessoryId: accessory.headerId ?? '',
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () {
          if (_validateForm()) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CustomerDetailsBookingPage(),
              ),
            );
          }
        },
      ),
    );
  }
}
