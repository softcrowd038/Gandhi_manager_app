// ignore_for_file: deprecated_member_use

import 'package:provider/provider.dart';
import 'package:gandhi_tvs/common/app_imports.dart';

class ItemSelectionContainer extends StatefulWidget {
  const ItemSelectionContainer({
    super.key,
    required this.accessory,
    required this.isMandatory,
    required this.accessoryId,
    this.showValidationError = false,
  });

  final String? accessory;
  final bool? isMandatory;
  final String? accessoryId;
  final bool showValidationError;

  @override
  State<ItemSelectionContainer> createState() => _ItemSelectionContainerState();
}

class _ItemSelectionContainerState extends State<ItemSelectionContainer> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedModelHeadersProvider>(
      builder: (context, selectedProvider, child) {
        final isSelected = widget.isMandatory == true
            ? true
            : selectedProvider.isSelected(widget.accessoryId ?? '');

        final hasError =
            widget.isMandatory == true &&
            !isSelected &&
            widget.showValidationError;

        return Container(
          margin: EdgeInsets.symmetric(
            vertical: SizeConfig.screenHeight * 0.008,
          ),
          decoration: BoxDecoration(
            color: widget.isMandatory == true
                ? Colors.grey.shade300
                : isSelected
                ? Colors.blue.withOpacity(0.2)
                : Colors.white,
            border: Border.all(
              color: hasError
                  ? Colors.red
                  : widget.isMandatory == true
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
                    onChanged: widget.isMandatory == true
                        ? null
                        : (bool? value) {
                            if (widget.accessoryId != null) {
                              selectedProvider.toggleHeader(
                                widget.accessoryId!,
                              );
                            }
                          },
                    checkColor: widget.isMandatory == true
                        ? Colors.grey.shade200
                        : Colors.white,
                    activeColor: widget.isMandatory == true
                        ? Colors.grey.shade400
                        : Colors.blue,
                    side: const BorderSide(width: 0.5, color: Colors.black38),
                    shape: const CircleBorder(),
                  ),
                  Expanded(
                    child: Text(
                      widget.accessory ?? 'Unknown',
                      style: TextStyle(
                        fontSize: SizeConfig.screenHeight * 0.018,
                        color: widget.isMandatory == true
                            ? Colors.grey.shade600
                            : isSelected
                            ? Colors.blue.shade900
                            : Colors.black,
                        fontWeight: isSelected
                            ? FontWeight.w300
                            : FontWeight.w300,
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
      },
    );
  }
}
