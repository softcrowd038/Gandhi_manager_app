import 'package:gandhi_tvs/common/app_imports.dart';

class LableWithIcon extends StatelessWidget {
  const LableWithIcon({
    super.key,
    required this.lable,
    required this.colors,
    required this.textColors,
    required this.circle,
    required this.size,
    required this.fontWeight,
  });

  final String? lable;
  final Color? colors;
  final Color? textColors;
  final IconData circle;
  final double? size;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(circle, color: colors, size: size),
        SizedBox(width: AppDimensions.height1),
        Flexible(
          child: Text(
            lable ?? "",
            style: TextStyle(
              fontSize: AppFontSize.s16,
              fontWeight: fontWeight,
              color: textColors,
            ),
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}
