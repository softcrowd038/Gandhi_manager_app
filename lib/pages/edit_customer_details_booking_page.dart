// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

class EditCustomerDetailsBookingPage extends StatefulWidget {
  final String? bookingId;
  const EditCustomerDetailsBookingPage({super.key, required this.bookingId});

  @override
  State<EditCustomerDetailsBookingPage> createState() =>
      _CustomerDetailsBookingPageState();
}

class _CustomerDetailsBookingPageState
    extends State<EditCustomerDetailsBookingPage> {
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
  String? fetchedBirthdate;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
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

        setState(() {
          selectedSaluation = bookingData.customerDetails.salutation;
          selectedOccupation = bookingData.customerDetails.occupation;
        });

        nameController.text = bookingData.customerDetails.name ?? '';
        address1Controller.text = bookingData.customerDetails.address ?? '';

        occuationController.text = bookingData.customerDetails.occupation ?? '';
        nomineeController.text = bookingData.customerDetails.nomineeName ?? '';
        nomineeRelationController.text =
            bookingData.customerDetails.nomineeRelation ?? '';
        nomineeAgeController.text =
            bookingData.customerDetails.nomineeAge?.toString() ?? '';
        talukaController.text = bookingData.customerDetails.taluka ?? '';
        pinController.text = bookingData.customerDetails.pincode ?? '';
        districtController.text = bookingData.customerDetails.district ?? '';
        mobile1Controller.text = bookingData.customerDetails.mobile1 ?? '';
        mobile2Controller.text = bookingData.customerDetails.mobile2 ?? '';
        aadharController.text = bookingData.customerDetails.aadharNumber ?? '';
        panCardController.text = bookingData.customerDetails.panNo ?? '';
        saluationController.text = bookingData.customerDetails.salutation ?? '';

        fetchedBirthdate = bookingData.customerDetails.dob?.toIso8601String();

        bookingFormProvider.setSalutation(
          bookingData.customerDetails.salutation ?? "",
        );
        bookingFormProvider.setName(bookingData.customerDetails.name ?? "");
        bookingFormProvider.setAddress(
          bookingData.customerDetails.address ?? "",
        );
        bookingFormProvider.setOccupation(
          bookingData.customerDetails.occupation ?? "",
        );
        bookingFormProvider.setNomineeName(
          bookingData.customerDetails.nomineeName ?? "",
        );
        bookingFormProvider.setNomineeRelation(
          bookingData.customerDetails.nomineeRelation ?? "",
        );
        bookingFormProvider.setNomineeAge(
          bookingData.customerDetails.nomineeAge ?? 0,
        );
        bookingFormProvider.setTaluka(bookingData.customerDetails.taluka ?? "");
        bookingFormProvider.setPincode(
          bookingData.customerDetails.pincode ?? "",
        );
        bookingFormProvider.setDistrict(
          bookingData.customerDetails.district ?? "",
        );
        bookingFormProvider.setMobile1(
          bookingData.customerDetails.mobile1 ?? "",
        );
        bookingFormProvider.setMobile2(
          bookingData.customerDetails.mobile2 ?? "",
        );
        bookingFormProvider.setAadharNumber(
          bookingData.customerDetails.aadharNumber ?? "",
        );
        bookingFormProvider.setPanNumber(
          bookingData.customerDetails.panNo ?? "",
        );

        setState(() {});
      }
    } catch (e) {
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
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
                          label: 'Mr',
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
                            validator: (value) => Validators.requiredField(
                              value,
                              fieldName: "name",
                            ),
                            obscureText: false,
                            controller: nameController,
                            keyboardType: TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                    DateSelector(birthDayDate: fetchedBirthdate),
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
                          {
                            "label": "Government Job",
                            "value": "Government Job",
                          },
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
                            validator: (value) => Validators.requiredField(
                              value,
                              fieldName: "taluka",
                            ),
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
                        panCardController.value = panCardController.value
                            .copyWith(
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
                      validator: (value) => Validators.requiredField(
                        value,
                        fieldName: "Nominee Name",
                      ),
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
                            onChanged: (value) => bookingFormProvider
                                .setNomineeAge(int.tryParse(value) ?? 0),
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
              MaterialPageRoute(
                builder: (_) =>
                    EditExchangeModeBooking(bookingId: widget.bookingId),
              ),
            );
          }
        },
      ),
    );
  }
}
