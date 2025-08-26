import 'package:gandhi_tvs/common/app_imports.dart';

class BookingStatusContainer extends StatelessWidget {
  const BookingStatusContainer({
    super.key,
    required this.label,
    required this.status1,
  });

  final String? label;
  final String? status1;

  @override
  Widget build(BuildContext context) {
    final Color bgColor = getContainerColor(status1);
    final Color labelColor = getContainerLabel(status1);
    final labelUpdated = getContainerLabelText(status1);

    // print(label);

    return Container(
      width: AppDimensions.fullWidth,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppBorderRadius.r1,
      ),
      child: Padding(
        padding: AppPadding.p1,
        child: Text(
          labelUpdated,
          style: TextStyle(
            color: labelColor,
            fontWeight: FontWeight.w600,
            fontSize: AppFontSize.s14,
          ),
        ),
      ),
    );
  }
}
