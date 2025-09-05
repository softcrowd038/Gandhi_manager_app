import 'package:gandhi_tvs/common/app_imports.dart';

class StatusChangeContainer extends StatelessWidget {
  const StatusChangeContainer({
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
        color: status1 == "PENDING"
            ? Colors.yellow[50]
            : status1 == "APPROVED"
            ? Colors.green[100]
            : Colors.red[100],
        borderRadius: AppBorderRadius.r1,
      ),
      child: Padding(
        padding: AppPadding.p1,
        child: Center(
          child: Text(
            label ?? "",
            style: TextStyle(
              color: status1 == "PENDING"
                  ? Colors.amber
                  : status1 == "APPROVED"
                  ? Colors.green
                  : Colors.red,
              fontWeight: FontWeight.w600,
              fontSize: AppFontSize.s14,
            ),
          ),
        ),
      ),
    );
  }
}
