import 'package:gandhi_tvs/common/app_imports.dart';

class InwardModelStatusContainer extends StatelessWidget {
  const InwardModelStatusContainer({
    super.key,
    required this.label,
    required this.status1,
  });

  final String? label;
  final String? status1;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getStatusColor(status1),
        borderRadius: AppBorderRadius.r1,
      ),
      child: Padding(
        padding: AppPadding.p1,
        child: Text(
          label ?? "",
          style: TextStyle(
            color: getStatusLableColor(status1),
            fontWeight: FontWeight.w600,
            fontSize: AppFontSize.s14,
          ),
        ),
      ),
    );
  }
}
