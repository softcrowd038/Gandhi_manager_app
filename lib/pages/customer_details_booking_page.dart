import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

class CustomerDetailsBookingPage extends StatefulWidget {
  const CustomerDetailsBookingPage({super.key});

  @override
  State<CustomerDetailsBookingPage> createState() =>
      _CustomerDetailsBookingPageState();
}

class _CustomerDetailsBookingPageState
    extends State<CustomerDetailsBookingPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final address1Controller = TextEditingController();
  final occuationController = TextEditingController();
  final nomineeController = TextEditingController();
  final nomineeRelationController = TextEditingController();
  final nomineeAgeController = TextEditingController();
  final talukaController = TextEditingController();
  final pinController = TextEditingController();
  final districtController = TextEditingController();
  final mobile1Controller = TextEditingController();
  final mobile2Controller = TextEditingController();
  final aadharController = TextEditingController();
  final panCardController = TextEditingController();
  final saluationController = TextEditingController();

  String? selectedSaluation;
  String? selectedOccupation;

  @override
  void dispose() {
    nameController.dispose();
    address1Controller.dispose();
    occuationController.dispose();
    nomineeController.dispose();
    nomineeRelationController.dispose();
    nomineeAgeController.dispose();
    talukaController.dispose();
    pinController.dispose();
    districtController.dispose();
    mobile1Controller.dispose();
    mobile2Controller.dispose();
    aadharController.dispose();
    panCardController.dispose();
    saluationController.dispose();
    super.dispose();
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
        title: StepsAppbarPlain(title: 'Step 3', subtitle: 'Customer Details'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(title: 'Personal Details'),
              Row(
                children: [
                  CustomizeDropDownMenu(
                    entries: [
                      {"Mr.": "Mr."},
                      {"Mrs.": "Mrs."},
                      {"Miss.": "Miss."},
                    ],
                    label: 'Sal.',
                    dropDownEditingController: saluationController,
                    selectedCustomerType: ValueNotifier<String?>(
                      selectedSaluation,
                    ),
                    onSelected: (String? value) {
                      bookingFormProvider.setSalutation(value ?? "");
                      setState(() => selectedSaluation = value);
                      saluationController.text = value ?? '';
                    },
                  ),
                  Expanded(
                    child: CustomTextFieldOutlined(
                      label: "Name",
                      hintText: "Adam Cena",
                      suffixIcon: Icons.person,
                      suffixIconColor: Colors.grey,
                      onChanged: bookingFormProvider.setName,
                      validator: (value) =>
                          Validators.requiredField(value, fieldName: "name"),
                      obscureText: false,
                      controller: nameController,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              DateSelector(),
              Padding(
                padding: EdgeInsets.all(
                  MediaQuery.of(context).size.height * 0.012,
                ),
                child: CustomDropDownWithLeadingIcon(
                  dropDownEditingController: occuationController,
                  selectedCustomerType: ValueNotifier<String?>(
                    selectedOccupation,
                  ),
                  entries: [
                    {"label": "Business", "value": "Business"},
                    {"label": "Farmer", "value": "Farmer"},
                    {"label": "Private Job", "value": "Private Job"},
                    {"label": "Government Job", "value": "Government Job"},
                    {"label": "Students", "value": "Students"},
                    {"label": "CSD", "value": "CSD"},
                  ],
                  hintText: "Select Occupation",
                  label: "Occupation",
                  icon: Icons.person,
                  onSelected: (String? value) {
                    setState(() => selectedOccupation = value);
                    bookingFormProvider.setOccupation(value ?? "");
                    occuationController.text = value ?? '';
                  },
                ),
              ),
              SectionTitle(title: 'Address Details'),
              CustomTextFieldOutlined(
                label: 'Address',
                hintText: 'Enter address',
                suffixIcon: Icons.home,
                suffixIconColor: Colors.black54,
                obscureText: false,
                controller: address1Controller,
                validator: (value) =>
                    Validators.requiredField(value, fieldName: "address"),
                onChanged: bookingFormProvider.setAddress,
                keyboardType: TextInputType.text,
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
                      validator: (value) =>
                          Validators.requiredField(value, fieldName: "taluka"),
                      onChanged: bookingFormProvider.setTaluka,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomTextFieldOutlined(
                      label: 'District',
                      hintText: 'Enter district',
                      suffixIcon: Icons.location_on,
                      suffixIconColor: Colors.black54,
                      obscureText: false,
                      controller: districtController,
                      validator: (value) => Validators.requiredField(
                        value,
                        fieldName: "district",
                      ),
                      onChanged: bookingFormProvider.setDistrict,
                      keyboardType: TextInputType.text,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFieldOutlined(
                      label: 'Pincode',
                      hintText: 'Enter Pincode',
                      suffixIcon: Icons.pin,
                      suffixIconColor: Colors.black54,
                      obscureText: false,
                      controller: pinController,
                      validator: Validators.pincode,
                      onChanged: bookingFormProvider.setPincode,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(width: SizeConfig.screenWidth * 0.5),
                  ),
                ],
              ),
              SectionTitle(title: 'Contact Details'),
              CustomTextFieldOutlined(
                label: 'Mobile Number 1',
                hintText: 'Enter mobile number',
                suffixIcon: Icons.phone_android,
                suffixIconColor: Colors.black54,
                obscureText: false,
                controller: mobile1Controller,
                validator: Validators.mobileNumber,
                onChanged: bookingFormProvider.setMobile1,
                keyboardType: TextInputType.number,
              ),
              CustomTextFieldOutlined(
                label: 'Mobile Number 2',
                hintText: 'Enter alternate mobile number',
                suffixIcon: Icons.phone_android,
                suffixIconColor: Colors.black54,
                obscureText: false,
                controller: mobile2Controller,
                validator: Validators.mobileNumber,
                onChanged: bookingFormProvider.setMobile2,
                keyboardType: TextInputType.number,
              ),
              SectionTitle(title: 'Verification Details'),
              CustomTextFieldOutlined(
                label: 'Aadhar Number',
                hintText: 'Enter Aadhar number',
                suffixIcon: FontAwesomeIcons.addressCard,
                suffixIconColor: Colors.black54,
                obscureText: false,
                controller: aadharController,
                validator: Validators.aadhaarNumber,
                onChanged: bookingFormProvider.setAadharNumber,
                keyboardType: TextInputType.number,
              ),
              CustomTextFieldOutlined(
                label: 'Pan Card Number',
                hintText: 'Enter PAN number',
                suffixIcon: FontAwesomeIcons.idCard,
                suffixIconColor: Colors.black54,
                obscureText: false,
                controller: panCardController,
                validator: Validators.panNumber,
                onChanged: (value) {
                  final uppercaseValue = value.toUpperCase();
                  panCardController.value = panCardController.value.copyWith(
                    text: uppercaseValue,
                    selection: TextSelection.collapsed(
                      offset: uppercaseValue.length,
                    ),
                  );
                  bookingFormProvider.setPanNumber(uppercaseValue);
                },
                keyboardType: TextInputType.text,
              ),
              SectionTitle(title: 'Nominee Details'),
              CustomTextFieldOutlined(
                label: 'Name',
                hintText: 'Enter Name',
                suffixIcon: Icons.person,
                suffixIconColor: Colors.black54,
                obscureText: false,
                controller: nomineeController,
                validator: (value) =>
                    Validators.requiredField(value, fieldName: "Nominee Name"),
                onChanged: bookingFormProvider.setNomineeName,
                keyboardType: TextInputType.text,
              ),
              CustomTextFieldOutlined(
                label: 'Relation',
                hintText: 'Enter Relation',
                suffixIcon: Icons.handshake,
                suffixIconColor: Colors.black54,
                obscureText: false,
                controller: nomineeRelationController,
                validator: (value) => Validators.requiredField(
                  value,
                  fieldName: "Nominee Relation",
                ),
                onChanged: bookingFormProvider.setNomineeRelation,
                keyboardType: TextInputType.text,
              ),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFieldOutlined(
                      label: 'Age',
                      hintText: 'Enter Age',
                      suffixIcon: Icons.calendar_month_sharp,
                      suffixIconColor: Colors.black54,
                      obscureText: false,
                      controller: nomineeAgeController,
                      validator: Validators.age,
                      onChanged: (value) => bookingFormProvider.setNomineeAge(
                        int.tryParse(value) ?? 0,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Expanded(
                    child: SizedBox(width: SizeConfig.screenWidth * 0.5),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () {
          if (selectedSaluation == null) {
            showSnackBar(context, 'Please select a Salutation');
          } else if (selectedOccupation == null) {
            showSnackBar(context, 'Please select an Occupation');
          } else if (formKey.currentState!.validate()) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ExchangeModeBooking()),
            );
          }
        },
      ),
    );
  }
}
