// ignore_for_file: unnecessary_null_comparison, unrelated_type_equality_checks, use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class RegisterCustomerPage extends StatefulWidget {
  const RegisterCustomerPage({super.key});

  @override
  State<RegisterCustomerPage> createState() => _RegisterCustomerPageState();
}

class _RegisterCustomerPageState extends State<RegisterCustomerPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController talukaController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController mobile1Controller = TextEditingController();
  TextEditingController mobile2Controller = TextEditingController();

  bool financeNeeded = false;
  DateTime? expectedDate;
  bool isLoading = false;

  Future<void> _submitForm() async {
    if (!formKey.currentState!.validate()) return;

    if (expectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select expected date')),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final selectedModelsProvider = Provider.of<SelectedModelsProvider>(
        context,
        listen: false,
      );

      QuotationService quotationService = QuotationService();

      final response = await quotationService.generateQuotation(
        GenerateQuotation(
          customerDetails: CustomerDetails(
            name: nameController.text,
            address: addressController.text,
            taluka: talukaController.text,
            district: districtController.text,
            mobile1: mobile1Controller.text,
            mobile2: mobile2Controller.text,
          ),
          selectedModels: selectedModelsProvider.selectedModels
              .map((model) => SelectedModel(modelId: model.modelId ?? ""))
              .toList(),
          expectedDeliveryDate: expectedDate!,
          financeNeeded: financeNeeded,
        ),
      );

      if (response['status'] == 'success') {
        final quotationId =
            response['data']['quotation_id'] ?? response['data']['id'];

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Quotation successfully created and shared!'),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PdfPreviewScreen(
              quotationId: quotationId,
              phoneNumber: mobile1Controller.text,
            ),
          ),
        );
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response['message'] ?? 'An error occurred')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: StepsAppbarPlain(title: 'Step 2', subtitle: 'Register User'),
      ),
      body: Padding(
        padding: AppPadding.p2,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter Customer Details Carefully',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: AppFontWeight.w600,
                    fontSize: AppFontSize.s18,
                  ),
                ),
                CustomTextFieldOutlined(
                  label: 'Customer Name',
                  hintText: 'Enter customer name',
                  suffixIcon: Icons.person,
                  suffixIconColor: Colors.black54,
                  obscureText: false,
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter Customer name';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                ),
                CustomTextFieldOutlined(
                  label: 'Address',
                  hintText: 'Enter address',
                  suffixIcon: Icons.home,
                  suffixIconColor: Colors.black54,
                  obscureText: false,
                  controller: addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter address';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                ),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFieldOutlined(
                        label: 'Taluka',
                        hintText: 'Enter taluka',
                        suffixIcon: Icons.location_city,
                        suffixIconColor: Colors.black54,
                        obscureText: false,
                        controller: talukaController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter taluka';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    SizedBox(width: AppDimensions.width2),
                    Expanded(
                      child: CustomTextFieldOutlined(
                        label: 'District',
                        hintText: 'Enter district',
                        suffixIcon: Icons.location_on,
                        suffixIconColor: Colors.black54,
                        obscureText: false,
                        controller: districtController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter district';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        keyboardType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                CustomTextFieldOutlined(
                  label: 'Mobile Number 1',
                  hintText: 'Enter mobile number',
                  suffixIcon: Icons.phone,
                  suffixIconColor: Colors.black54,
                  obscureText: false,
                  controller: mobile1Controller,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length != 10) {
                      return 'Enter valid 10 digit number';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  keyboardType: TextInputType.number,
                ),
                CustomTextFieldOutlined(
                  label: 'Mobile Number 2',
                  hintText: 'Enter alternate mobile number',
                  suffixIcon: Icons.phone_android,
                  suffixIconColor: Colors.black54,
                  obscureText: false,
                  controller: mobile2Controller,
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        value.length != 10) {
                      return 'Enter valid 10 digit number';
                    }
                    return null;
                  },
                  onChanged: (value) {},
                  keyboardType: TextInputType.number,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Finance Needed?',
                      style: TextStyle(
                        fontSize: height * 0.018,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Switch(
                      value: financeNeeded,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        setState(() {
                          financeNeeded = value;
                        });
                      },
                    ),
                  ],
                ),
                Text(
                  'Expected Date',
                  style: TextStyle(
                    fontSize: height * 0.018,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                InkWell(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        expectedDate = pickedDate;
                      });
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: AppDimensions.height2,
                      horizontal: AppDimensions.width2,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      expectedDate == null
                          ? 'Select Date'
                          : DateFormat('dd-MM-yyyy').format(expectedDate!),
                      style: TextStyle(
                        fontSize: height * 0.017,
                        color: expectedDate == null
                            ? Colors.black38
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppDimensions.height4),
                !isLoading
                    ? GestureDetector(
                        onTap: () => _submitForm(),
                        child: FlatButtonWidget(
                          borderRadius: 0.05,
                          text: 'Preview and Print',
                          height: 0.06,
                          width: 1,
                          textFontSize: 0.020,
                          color: const Color(0xFF4965e9),
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(color: Colors.blue),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
