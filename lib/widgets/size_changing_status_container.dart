import 'package:gandhi_tvs/common/app_imports.dart';

class SizeChangingStatusContainer extends StatelessWidget {
  const SizeChangingStatusContainer({
    super.key,
    required this.label,
    required this.status1,
    required this.value,
  });

  final String? label;
  final String? value;
  final String? status1;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = getStatusBackgroundColor(status1);
    final Color labelColor = getStatusLabelColor(status1);

    return Container(
      width: AppDimensions.fullWidth,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppBorderRadius.r1,
      ),
      child: Padding(
        padding: AppPadding.p1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label == "PENDING_APPROVAL (Discount_Exceeded)"
                  ? 'Discount Exceeded'
                  : label ?? "",
              style: TextStyle(
                color: labelColor,
                fontWeight: FontWeight.w600,
                fontSize: AppFontSize.s14,
              ),
            ),
            Text(
              value ?? "",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: AppFontSize.s14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
