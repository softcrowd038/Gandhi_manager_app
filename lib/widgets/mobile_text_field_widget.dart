import 'package:gandhi_tvs/common/app_imports.dart';

class MobileTextFieldWidget extends HookWidget {
  final TextEditingController mobileController;

  const MobileTextFieldWidget({super.key, required this.mobileController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: mobileController,
      keyboardType: TextInputType.number,
      autocorrect: true,
      style: TextStyle(
        color: Colors.black,
        fontSize: SizeConfig.screenHeight * 0.018,
      ),
      decoration: InputDecoration(
        hintText: 'xxxxxxxxxx',
        hintStyle: TextStyle(
          color: Colors.grey.shade600,
          fontSize: SizeConfig.screenHeight * 0.016,
        ),
        labelText: 'Mobile Number',
        labelStyle: TextStyle(
          color: Colors.black,
          fontSize: SizeConfig.screenHeight * 0.018,
          fontWeight: FontWeight.w500,
        ),
        errorStyle: TextStyle(
          color: Colors.redAccent,
          fontSize: SizeConfig.screenHeight * 0.014,
        ),
        prefixIcon: Icon(
          Icons.smartphone,
          color: Colors.red,
          size: SizeConfig.screenHeight * 0.030,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: SizeConfig.screenHeight * 0.02,
          horizontal: SizeConfig.screenWidth * 0.04,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Mobile number is required';
        }
        if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
          return 'Enter a valid 10-digit mobile number';
        }
        return null;
      },
      onChanged: (value) {},
    );
  }
}
