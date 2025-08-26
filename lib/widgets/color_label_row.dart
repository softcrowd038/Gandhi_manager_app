import 'package:gandhi_tvs/common/app_imports.dart';

class ColorLabelRow extends StatelessWidget {
  const ColorLabelRow({
    super.key,
    required this.color,
    required this.label,
    required this.value,
  });
  final Color? color;
  final String? label;
  final String? value;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.p2,
      child: Container(
        padding: AppPadding.p1,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.textSecondary),
          borderRadius: AppBorderRadius.r2,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.circle, color: color, size: AppDimensions.height1),
                SizedBox(width: AppDimensions.height1),
                Text(
                  label ?? "",
                  style: TextStyle(
                    fontWeight: AppFontWeight.bold,
                    fontSize: AppFontSize.s16,
                  ),
                ),
              ],
            ),
            Text(
              value ?? "",
              style: TextStyle(
                fontWeight: AppFontWeight.w500,
                fontSize: AppFontSize.s14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
