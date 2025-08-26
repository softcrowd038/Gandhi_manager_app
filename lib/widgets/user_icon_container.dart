// ignore_for_file: deprecated_member_use

import 'package:gandhi_tvs/common/app_imports.dart';

class UserIconContainer extends StatelessWidget {
  const UserIconContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.3),
        borderRadius: AppBorderRadius.r4,
      ),
      child: ClipRRect(
        borderRadius: AppBorderRadius.r4,
        child: Padding(
          padding: AppPadding.p2,
          child: const Icon(Icons.person, color: Colors.blue),
        ),
      ),
    );
  }
}
