import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_bookings_model.dart';
import 'package:provider/provider.dart';

class UpdateChassisPage extends HookWidget {
  const UpdateChassisPage({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final chassisNumberController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final globalKey = useMemoized(() => GlobalKey<FormState>());
    final allocateChassisProvider = Provider.of<AllocateChassisProvider>(
      context,
      listen: false,
    );

    final formErrors = useState<Map<String, String?>>({});
    final selectedChassisNumber = useState<String?>(null);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final getChassisProvider = Provider.of<GetChassisNumbersProvider>(
          context,
          listen: false,
        );
        getChassisProvider.fetchChassisNumbers(
          context,
          booking.model.id ?? "",
          booking.color.id ?? "",
        );

        chassisNumberController.text = booking.chassisNumber ?? "";
      });
      return null;
    }, []);

    String? validateRequired(String? value, String fieldName) {
      if (value == null || value.isEmpty) {
        return '$fieldName is required';
      }
      return null;
    }

    bool validateForm() {
      final errors = <String, String?>{};

      errors['chassisNumber'] = validateRequired(
        chassisNumberController.text,
        'Chassis Number',
      );

      formErrors.value = errors;
      return errors.values.every((error) => error == null);
    }

    void submitChassisAllocation() {
      if (!validateForm()) {
        return;
      }

      if (descriptionController.text.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Reason is required')));
        return;
      }

      try {
        final chassisAllocationModel = ChassisAllocationModel(
          chassisNumber: chassisNumberController.text,
          reason: descriptionController.text,
        );

        allocateChassisProvider.allocateChassis(
          context,
          booking.id,
          chassisAllocationModel,
        );
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: globalKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomerHeader(
                  customerName:
                      "${booking.customerDetails.salutation} ${booking.customerDetails.name}",
                  address: booking.model.modelName ?? "",
                  bookingId: booking.bookingNumber ?? "",
                ),
                const Divider(),

                SectionTitle(title: "Chassis Allocation Details"),

                Padding(
                  padding: EdgeInsets.all(SizeConfig.screenHeight * 0.01),
                  child: Consumer<GetChassisNumbersProvider>(
                    builder: (context, provider, child) {
                      final chassisNumbers =
                          provider.chassisNumberModel?.data.chassisNumbers ??
                          [];

                      final entries = chassisNumbers
                          .map(
                            (chassis) => {"label": chassis, "value": chassis},
                          )
                          .toList();

                      if (entries.isEmpty) {
                        entries.add({
                          "label": "No chassis numbers available",
                          "value": "",
                        });
                      }

                      return CustomDropDownWithLeadingIcon(
                        entries: entries,
                        label: 'Select Chassis Number',
                        dropDownEditingController: chassisNumberController,
                        selectedCustomerType: ValueNotifier<String?>(
                          selectedChassisNumber.value,
                        ),
                        hintText: "Select Chassis Number",
                        icon: Icons.directions_car,
                        onSelected: (String? value) {
                          selectedChassisNumber.value = value;
                          chassisNumberController.text = value ?? '';
                        },
                      );
                    },
                  ),
                ),

                Padding(
                  padding: AppPadding.p2,
                  child: OutlinedBorderTextfieldWidget(
                    label: "Description *",
                    hintText: "Enter claim description",
                    controller: descriptionController,
                    validator: (value) =>
                        validateRequired(value, 'Description'),
                    obscureText: false,
                    keyboardType: TextInputType.multiline,
                    onChanged: (value) {},
                    suffixIcon: Icons.description,
                    suffixIconColor: Colors.grey,
                  ),
                ),

                Padding(
                  padding: AppPadding.p2,
                  child: GestureDetector(
                    onTap: submitChassisAllocation,
                    child: Container(
                      height: AppDimensions.height6,
                      width: AppDimensions.fullWidth,
                      decoration: const BoxDecoration(color: AppColors.primary),
                      child: Center(
                        child: Consumer<AllocateChassisProvider>(
                          builder: (context, provider, child) {
                            return provider.isLoading
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    "UPDATE CHASSIS",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: AppFontSize.s18,
                                      fontWeight: AppFontWeight.bold,
                                    ),
                                  );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
