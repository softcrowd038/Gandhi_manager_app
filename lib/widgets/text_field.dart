import 'package:gandhi_tvs/common/app_imports.dart';

class TextFieldWidget extends HookWidget {
  final TextEditingController controller;
  final String hintText;
  final String lableText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Icon? prefixIcon;
  final String? Function(String?)? validator;

  const TextFieldWidget({
    super.key,
    required this.controller,
    required this.lableText,
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.012),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          labelText: lableText,
          labelStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.016,
          ),
          hintStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.016,
            color: Colors.black12,
          ),
          prefixIcon: prefixIcon,
          border: const UnderlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }
}
