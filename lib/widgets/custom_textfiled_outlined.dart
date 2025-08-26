import 'package:gandhi_tvs/common/app_imports.dart';

class CustomTextFieldOutlined extends HookWidget {
  final String label;
  final String hintText;
  final IconData suffixIcon;
  final Color suffixIconColor;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const CustomTextFieldOutlined({
    super.key,
    required this.label,
    required this.hintText,
    required this.suffixIcon,
    required this.suffixIconColor,
    required this.onChanged,
    required this.validator,
    this.obscureText = false,
    required this.controller,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: deviceHeight * 0.008,
        vertical: deviceHeight * 0.008,
      ),
      child: TextFormField(
        controller: controller,
        cursorColor: Colors.black,
        onChanged: onChanged,
        validator: validator,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          suffixIcon: Icon(
            suffixIcon,
            color: suffixIconColor,
            size: SizeConfig.screenHeight * 0.024,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.divider),
            borderRadius: AppBorderRadius.r4,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.divider),
            borderRadius: AppBorderRadius.r4,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black38,
            fontSize: deviceHeight * 0.016,
          ),
          label: Text(
            label,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: deviceHeight * 0.018,
            ),
          ),
        ),
      ),
    );
  }
}
