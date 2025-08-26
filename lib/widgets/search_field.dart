import 'package:gandhi_tvs/common/app_imports.dart';

class SearchField extends HookWidget {
  final TextEditingController controller;
  final Function(String) onChanged;
  final String labelText;

  const SearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppDimensions.height1),
      child: SizedBox(
        height: AppDimensions.height8,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: const TextStyle(color: Colors.black26, fontSize: 14),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.height * 0.070,
              ),
            ),
            prefixIcon: const Icon(Icons.search, size: 16),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black54),
              borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.height * 0.100,
              ),
            ),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
