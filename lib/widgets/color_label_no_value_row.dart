import 'package:gandhi_tvs/common/app_imports.dart';

class ColorLabelNoValueRow extends StatelessWidget {
  const ColorLabelNoValueRow({
    super.key,
    required this.color,
    required this.label,
  });
  final Color? color;
  final String? label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.p2,
      child: Row(
        children: [
          Icon(Icons.circle, color: color, size: AppDimensions.width2),
          SizedBox(width: AppDimensions.height1),
          Text(
            label ?? "",
            style: TextStyle(
              fontWeight: AppFontWeight.w500,
              fontSize: AppFontSize.s16,
            ),
          ),
        ],
      ),
    );
  }
}
