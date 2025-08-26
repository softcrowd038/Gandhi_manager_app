import 'package:gandhi_tvs/common/app_imports.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.p4,
      child: Text(
        title,
        style: TextStyle(
          fontSize: SizeConfig.screenHeight * 0.020,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
