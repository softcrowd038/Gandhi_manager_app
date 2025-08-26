import 'package:gandhi_tvs/common/app_imports.dart';

class TheWidthFullButton extends StatelessWidget {
  const TheWidthFullButton({
    super.key,
    required this.lable,
    required this.color,
  });

  final String lable;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight * 0.060,
      decoration: BoxDecoration(color: color),
      child: Center(
        child: Text(
          lable,
          style: TextStyle(
            color: Colors.white,
            fontWeight: AppFontWeight.bold,
            fontSize: AppFontSize.s18,
          ),
        ),
      ),
    );
  }
}
