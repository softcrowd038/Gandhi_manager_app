import 'package:gandhi_tvs/common/app_imports.dart';

class StepsAppbar extends HookWidget {
  final String title;
  final String subtitle;
  final void Function()? onTap;
  final Color color;
  const StepsAppbar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: MediaQuery.of(context).size.height * 0.020,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: MediaQuery.of(context).size.height * 0.020,
              color: Colors.black,
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w700,
                fontSize: MediaQuery.of(context).size.height * 0.018,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: MediaQuery.of(context).size.height * 0.020,
              color: Colors.black45,
            ),
          ],
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            "Next",
            style: TextStyle(
              color: color,
              fontSize: MediaQuery.of(context).size.height * 0.018,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
