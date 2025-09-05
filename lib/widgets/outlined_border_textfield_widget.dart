import 'package:gandhi_tvs/common/app_imports.dart';

class OutlinedBorderTextfieldWidget extends HookWidget {
  final String label;
  final String hintText;
  final IconData suffixIcon;
  final Color suffixIconColor;
  final Function(String) onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool? readOnly;

  const OutlinedBorderTextfieldWidget({
    super.key,
    required this.label,
    required this.hintText,
    required this.suffixIcon,
    required this.suffixIconColor,
    required this.onChanged,
    required this.validator,
    required this.obscureText,
    required this.controller,
    required this.keyboardType,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceHeight = size.height;

    return TextFormField(
      controller: controller,
      readOnly: readOnly ?? false,
      cursorColor: Colors.black,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: Icon(
          suffixIcon,
          color: suffixIconColor,
          size: SizeConfig.screenHeight * 0.024,
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.divider),
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
      obscureText: obscureText,
      keyboardType: keyboardType,
    );
  }
}
