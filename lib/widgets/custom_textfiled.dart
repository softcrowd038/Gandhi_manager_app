import 'package:gandhi_tvs/common/app_imports.dart';

class CustomTextField extends HookWidget {
  final String hintText;
  final Function(String) onChanged;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return TextFormField(
      controller: controller,
      cursorColor: Colors.black54,
      onChanged: onChanged,
      validator: validator,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.divider),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black38, fontSize: height * 0.018),
        alignLabelWithHint: true,
      ),
    );
  }
}
