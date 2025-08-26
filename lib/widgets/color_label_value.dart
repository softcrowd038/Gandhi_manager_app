import 'package:gandhi_tvs/common/app_imports.dart';

class ColorLabelValue extends StatelessWidget {
  final Color color;
  final String label;
  final String value;

  const ColorLabelValue({
    super.key,
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.circle, color: color, size: AppDimensions.height1),
            SizedBox(width: SizeConfig.screenWidth * 0.04),
            Text(
              label,
              style: TextStyle(
                color: Colors.black,
                fontWeight: AppFontWeight.bold,
              ),
            ),
          ],
        ),
        Text("₹$value", style: const TextStyle(color: Colors.black)),
      ],
    );
  }
}
