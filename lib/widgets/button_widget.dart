import 'package:gandhi_tvs/common/app_imports.dart';

class ButtonWidget extends HookWidget {
  final double textFontSize;
  final double height;
  final double width;
  final Color color;

  const ButtonWidget({
    super.key,
    required this.textFontSize,
    required this.height,
    required this.width,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final deviceHeight = size.height;

    return Padding(
      padding: EdgeInsets.all(deviceHeight * 0.012),
      child: GestureDetector(
        child: Container(
          height: deviceHeight * height,
          width: deviceHeight * height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(deviceHeight * height),
          ),
          child: Center(
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: deviceHeight * textFontSize,
            ),
          ),
        ),
      ),
    );
  }
}
