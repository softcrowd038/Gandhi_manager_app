// ignore_for_file: deprecated_member_use

import 'package:provider/provider.dart';
import 'package:gandhi_tvs/common/app_imports.dart';

class ContainerWithNameAndPrice extends StatelessWidget {
  const ContainerWithNameAndPrice({
    super.key,
    required this.accessoryName,
    required this.accessoryValue,
    required this.onSelectionChanged,
  });

  final String accessoryName;
  final int accessoryValue;
  final VoidCallback onSelectionChanged;

  @override
  Widget build(BuildContext context) {
    final selectedProvider = Provider.of<SelectedAccessoriesProvider>(context);
    final isSelected = selectedProvider.isSelected(accessoryName);

    return Container(
      margin: AppPadding.p2,
      decoration: BoxDecoration(
        color: isSelected ? Colors.blue.withOpacity(0.2) : Colors.white,
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.black38,
          width: 1,
        ),
        borderRadius: AppBorderRadius.r2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Checkbox(
            value: isSelected,
            onChanged: (bool? value) {
              selectedProvider.toggleAccessory(accessoryName);
              onSelectionChanged(); // ✅ update booking form
            },
            checkColor: Colors.blue,
            side: const BorderSide(width: 0.5, color: Colors.black38),
            activeColor: Colors.white,
            fillColor: const WidgetStatePropertyAll(Colors.white),
            shape: const CircleBorder(),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  accessoryName,
                  style: TextStyle(
                    fontSize: SizeConfig.screenHeight * 0.018,
                    color: isSelected ? Colors.blue.shade900 : Colors.black,
                    fontWeight: AppFontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    '₹$accessoryValue',
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.016,
                      color: AppColors.textPrimary,
                      fontWeight: isSelected
                          ? AppFontWeight.bold
                          : AppFontWeight.w200,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
