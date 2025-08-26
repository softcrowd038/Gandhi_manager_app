import 'package:gandhi_tvs/common/app_imports.dart';

class SizeChangingContainer extends StatelessWidget {
  const SizeChangingContainer({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.width,
    required this.color,
    required this.textColor,
  });

  final double? width;
  final String? icon;
  final String? title;
  final String? value;
  final Color? color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: MediaQuery.of(context).size.height * 0.070,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(MediaQuery.of(context).size.width * 0.8),
          bottomRight: Radius.circular(MediaQuery.of(context).size.width * 0.8),
        ),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: AppPadding.p2,
                child: Image.network(
                  icon ?? "",
                  height: AppDimensions.height8,
                  width: AppDimensions.width8,
                ),
              ),
              Text(
                title ?? "",
                style: TextStyle(
                  fontSize: AppFontSize.s18,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Padding(
            padding: AppPadding.p2,
            child: Text(
              value ?? "",
              style: TextStyle(
                fontSize: AppFontSize.s22,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
