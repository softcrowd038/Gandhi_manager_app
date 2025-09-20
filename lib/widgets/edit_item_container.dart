// ignore_for_file: deprecated_member_use

import 'package:gandhi_tvs/common/app_imports.dart';

class EditItemSelectionContainer extends StatefulWidget {
  const EditItemSelectionContainer({
    super.key,
    required this.accessory,
    required this.isMandatory,
    required this.accessoryId,
    required this.isSelected,
    this.showValidationError = false,
    this.onSelectionChanged,
  });

  final String? accessory;
  final bool? isMandatory;
  final String? accessoryId;
  final bool showValidationError;
  final bool isSelected;
  final Function(bool)? onSelectionChanged;

  @override
  State<EditItemSelectionContainer> createState() =>
      _EditItemSelectionContainerState();
}

class _EditItemSelectionContainerState
    extends State<EditItemSelectionContainer> {
  @override
  Widget build(BuildContext context) {
    final isSelected = widget.isSelected;
    final isMandatory = widget.isMandatory ?? false;

    final hasError = isMandatory && !isSelected && widget.showValidationError;

    return Container(
      margin: EdgeInsets.symmetric(vertical: SizeConfig.screenHeight * 0.008),
      decoration: BoxDecoration(
        color: isMandatory
            ? Colors.grey.shade300
            : isSelected
            ? Colors.blue.withOpacity(0.2)
            : Colors.white,
        border: Border.all(
          color: hasError
              ? Colors.red
              : isMandatory
              ? Colors.grey.shade300
              : isSelected
              ? Colors.blue
              : Colors.black38,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkbox(
                value: isSelected,
                onChanged: isMandatory
                    ? null
                    : (bool? value) {
                        if (value != null &&
                            widget.onSelectionChanged != null) {
                          widget.onSelectionChanged!(value);
                        }
                      },
                checkColor: isMandatory ? Colors.grey.shade200 : Colors.white,
                activeColor: isMandatory ? Colors.grey.shade400 : Colors.blue,
                side: const BorderSide(width: 0.5, color: Colors.black38),
                shape: const CircleBorder(),
              ),
              Expanded(
                child: Text(
                  widget.accessory ?? 'Unknown',
                  style: TextStyle(
                    fontSize: SizeConfig.screenHeight * 0.018,
                    color: isMandatory
                        ? Colors.grey.shade600
                        : isSelected
                        ? Colors.blue.shade900
                        : Colors.black,
                    fontWeight: isSelected ? FontWeight.w300 : FontWeight.w300,
                  ),
                ),
              ),
            ],
          ),
          if (hasError)
            Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.screenHeight * 0.014,
                bottom: 4,
              ),
              child: Text(
                'This is mandatory',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: SizeConfig.screenHeight * 0.014,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
