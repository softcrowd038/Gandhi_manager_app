import 'package:gandhi_tvs/common/app_imports.dart';

class CustomizeDropDownMenu extends StatelessWidget {
  const CustomizeDropDownMenu({
    super.key,
    required this.entries,
    required this.label,
    required this.selectedCustomerType,
    required this.dropDownEditingController,
    required this.onSelected,
  });

  final List<Map<String, String>> entries;
  final String label;
  final ValueNotifier<String?> selectedCustomerType;
  final TextEditingController dropDownEditingController;
  final void Function(String?)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(SizeConfig.screenHeight * 0.01),
      child: ValueListenableBuilder<String?>(
        valueListenable: selectedCustomerType,
        builder: (context, selectedValue, _) {
          return DropdownMenu<String>(
            initialSelection: selectedValue,
            menuStyle: MenuStyle(
              backgroundColor: const WidgetStatePropertyAll(Colors.white),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: AppBorderRadius.r2),
              ),
            ),
            label: Text(
              label,
              style: TextStyle(fontSize: SizeConfig.screenHeight * 0.016),
            ),
            width: SizeConfig.screenWidth * 0.30,
            onSelected: onSelected,
            dropdownMenuEntries: entries.map((entry) {
              final value = entry.keys.first;
              final label = entry.values.first;
              return DropdownMenuEntry<String>(value: value, label: label);
            }).toList(),
          );
        },
      ),
    );
  }
}
