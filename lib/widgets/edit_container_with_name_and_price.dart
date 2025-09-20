// ignore_for_file: deprecated_member_use

import 'package:gandhi_tvs/common/app_imports.dart';

class EditContainerWithNameAndPrice extends StatelessWidget {
  const EditContainerWithNameAndPrice({
    super.key,
    required this.accessoryName,
    required this.accessoryValue,
    required this.accessoryId,
    required this.onSelectionChanged,
    required this.isSelected,
  });

  final String accessoryName;
  final int accessoryValue;
  final String accessoryId;
  final VoidCallback onSelectionChanged;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
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
              onSelectionChanged();
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
                Expanded(
                  child: Text(
                    accessoryName,
                    style: TextStyle(
                      fontSize: SizeConfig.screenHeight * 0.016,
                      color: isSelected ? Colors.blue.shade900 : Colors.black,
                      fontWeight: AppFontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
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
