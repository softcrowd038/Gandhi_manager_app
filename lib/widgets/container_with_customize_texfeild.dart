import 'package:gandhi_tvs/common/app_imports.dart';

class ContainerWithCustomizeTextFeild extends StatelessWidget {
  const ContainerWithCustomizeTextFeild({
    super.key,
    required this.itemKey,
    required this.values,
    required this.ismandatory,
    required this.index,
    required this.itemGstRate,
  });

  final String itemKey;
  final dynamic values;
  final dynamic ismandatory;
  final int index;
  final String itemGstRate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.p2,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ismandatory == true ? Colors.white : Colors.grey.shade300,
          borderRadius: AppBorderRadius.r2,
          boxShadow: [
            BoxShadow(
              spreadRadius: 0.0,
              color: Colors.black26,
              blurRadius: 1,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: AppPadding.p2,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      itemKey,
                      style: TextStyle(
                        fontWeight: ismandatory == true
                            ? AppFontWeight.w300
                            : AppFontWeight.w300,
                        fontSize: AppFontSize.s18,
                        color: ismandatory == true
                            ? Colors.black
                            : Colors.grey.shade400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "₹ $values",
                    style: TextStyle(fontSize: AppFontSize.s16),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
