import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_bookings_model.dart';
import 'package:gandhi_tvs/models/allocate_chassis_model.dart';
import 'package:gandhi_tvs/provider/allocate_chassis_number_provider.dart';
import 'package:gandhi_tvs/provider/get_chassis_numbers_provider.dart';
import 'package:provider/provider.dart';

class AllocateChassisPage extends HookWidget {
  const AllocateChassisPage({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final chassisNumberController = useTextEditingController();
    final hasClaim = useState<bool>(false);
    final priceClaimController = useTextEditingController();
    final descriptionController = useTextEditingController();
    final documents = useState<List<PlatformFile>>([]);
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
          booking.model.id,
          booking.color.id,
        );
      });
      return null;
    }, []);

    // Function to pick multiple documents
    Future<void> pickDocuments() async {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          allowMultiple: true,
          type: FileType.custom,
          allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
        );

        if (result != null) {
          final newFiles = result.files;
          final totalFiles = documents.value.length + newFiles.length;

          if (totalFiles > 6) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Maximum 6 documents allowed. You have ${documents.value.length} already.',
                ),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }

          documents.value = [...documents.value, ...newFiles];
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking files: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }

    // Function to remove a document
    void removeDocument(int index) {
      final newDocuments = List<PlatformFile>.from(documents.value);
      newDocuments.removeAt(index);
      documents.value = newDocuments;
    }

    String? validateRequired(String? value, String fieldName) {
      if (value == null || value.isEmpty) {
        return '$fieldName is required';
      }
      return null;
    }

    String? validateNumber(String? value, String fieldName) {
      if (value == null || value.isEmpty) {
        return '$fieldName is required';
      }
      if (double.tryParse(value) == null) {
        return 'Please enter a valid number';
      }
      return null;
    }

    bool validateForm() {
      final errors = <String, String?>{};

      errors['chassisNumber'] = validateRequired(
        chassisNumberController.text,
        'Chassis Number',
      );

      if (hasClaim.value) {
        errors['priceClaim'] = validateNumber(
          priceClaimController.text,
          'Price Claim',
        );
        errors['description'] = validateRequired(
          descriptionController.text,
          'Description',
        );
      }

      formErrors.value = errors;
      return errors.values.every((error) => error == null);
    }

    void submitChassisAllocation() {
      if (!validateForm()) {
        return;
      }

      try {
        final chassisAllocationModel = ChassisAllocationModel(
          chassisNumber: chassisNumberController.text,
          hasClaim: hasClaim.value,
          priceClaim: hasClaim.value
              ? double.parse(priceClaimController.text)
              : null,
          description: hasClaim.value ? descriptionController.text : null,
          documents: documents.value.map((file) => file.xFile).toList(),
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
                  address: booking.model.modelName,
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

                SwitchListTile(
                  title: const Text("Is Any Claim ?"),
                  value: hasClaim.value,
                  onChanged: (val) {
                    hasClaim.value = val;
                  },
                  activeColor: Theme.of(context).primaryColor,
                ),

                if (hasClaim.value) ...[
                  Padding(
                    padding: AppPadding.p2,
                    child: OutlinedBorderTextfieldWidget(
                      label: "Price Claim *",
                      hintText: "Enter claim amount",
                      suffixIcon: Icons.currency_rupee,
                      suffixIconColor: Colors.grey,
                      controller: priceClaimController,
                      validator: (value) =>
                          validateNumber(value, 'Price Claim'),
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {},
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

                  SectionTitle(title: "Documents (Max 6)"),

                  Padding(
                    padding: AppPadding.p2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Document upload button with counter
                        GestureDetector(
                          onTap: documents.value.length >= 6
                              ? null
                              : pickDocuments,
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: documents.value.length >= 6
                                    ? Colors.grey
                                    : AppColors.primary,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: documents.value.length >= 6
                                  ? Colors.grey[200]
                                  : null,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.upload_file,
                                  color: documents.value.length >= 6
                                      ? Colors.grey
                                      : AppColors.primary,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  "Upload Document (${documents.value.length}/6)",
                                  style: TextStyle(
                                    color: documents.value.length >= 6
                                        ? Colors.grey
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 8),
                        Text(
                          "Supported formats: PDF, DOC, DOCX, JPG, JPEG, PNG",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),

                        if (documents.value.isNotEmpty) ...[
                          SizedBox(height: 16),
                          Text(
                            "Uploaded Documents:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 8),
                        ],

                        // Document list
                        ...documents.value.asMap().entries.map((entry) {
                          final index = entry.key;
                          final document = entry.value;
                          return Container(
                            margin: EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: ListTile(
                              leading: _getFileIcon(document.name),
                              title: Text(
                                document.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              subtitle: Text(
                                _formatFileSize(document.size),
                                style: TextStyle(fontSize: 12),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => removeDocument(index),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],

                const SizedBox(height: 24),

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
                                    "ALLOCATE CHASSIS",
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

  Icon _getFileIcon(String fileName) {
    final extension = fileName.split('.').last.toLowerCase();
    switch (extension) {
      case 'pdf':
        return Icon(Icons.picture_as_pdf, color: Colors.red);
      case 'doc':
      case 'docx':
        return Icon(Icons.description, color: Colors.blue);
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icon(Icons.image, color: Colors.green);
      default:
        return Icon(Icons.insert_drive_file, color: Colors.grey);
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(1)} ${suffixes[i]}';
  }
}
