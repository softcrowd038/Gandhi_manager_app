import 'package:gandhi_tvs/common/app_imports.dart';

class CustomDropDownWithLeadingIcon extends StatelessWidget {
  const CustomDropDownWithLeadingIcon({
    super.key,
    required this.dropDownEditingController,
    required this.selectedCustomerType,
    required this.entries,
    required this.hintText,
    required this.label,
    required this.icon,
    required this.onSelected,
    this.setDefault = false,
  });

  final TextEditingController dropDownEditingController;
  final ValueNotifier<String?> selectedCustomerType;
  final List<Map<String, String>> entries;
  final String hintText;
  final String label;
  final IconData icon;
  final void Function(String?)? onSelected;
  final bool setDefault;

  @override
  Widget build(BuildContext context) {
    if (setDefault &&
        (selectedCustomerType.value == null ||
            selectedCustomerType.value!.isEmpty) &&
        entries.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        selectedCustomerType.value = entries.first["value"];
        dropDownEditingController.text = entries.first["label"] ?? "";
        if (onSelected != null) {
          onSelected!(entries.first["value"]);
        }
      });
    }

    if (selectedCustomerType.value != null &&
        selectedCustomerType.value!.isNotEmpty) {
      final selectedEntry = entries.firstWhere(
        (entry) => entry["value"] == selectedCustomerType.value,
        orElse: () => {"label": "", "value": ""},
      );
      dropDownEditingController.text = selectedEntry["label"] ?? "";
    }

    return DropdownMenu<String>(
      controller: dropDownEditingController,
      dropdownMenuEntries: entries.map((entry) {
        return DropdownMenuEntry(
          value: entry["value"] ?? "",
          label: entry["label"] ?? "",
        );
      }).toList(),
      leadingIcon: Icon(icon, size: SizeConfig.screenHeight * 0.022),
      hintText: hintText,
      width: SizeConfig.screenHeight,
      label: Text(
        dropDownEditingController.text == ""
            ? label
            : dropDownEditingController.text,
        style: TextStyle(fontSize: SizeConfig.screenHeight * 0.016),
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.white),
        maximumSize: WidgetStatePropertyAll(
          Size(SizeConfig.screenWidth, SizeConfig.screenWidth),
        ),
      ),
      onSelected: onSelected,
    );
  }
}
