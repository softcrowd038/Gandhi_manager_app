import 'package:gandhi_tvs/common/app_imports.dart';

class FlatButtonWidget extends HookWidget {
  final String text;
  final double textFontSize;
  final double height;
  final double width;
  final double borderRadius;
  final Color color;

  const FlatButtonWidget({
    super.key,
    required this.text,
    required this.textFontSize,
    required this.height,
    required this.width,
    required this.borderRadius,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceHeight = size.height;
    final deviceWidth = size.width;

    return GestureDetector(
      child: Container(
        height: deviceHeight * height,
        width: deviceWidth * width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(deviceHeight * borderRadius),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: deviceHeight * textFontSize,
            ),
          ),
        ),
      ),
    );
  }
}
