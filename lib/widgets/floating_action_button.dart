import 'package:gandhi_tvs/common/app_imports.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const FloatingActionButtonWidget({
    super.key,
    required this.onPressed,
    this.icon = Icons.arrow_forward,
    this.backgroundColor = AppColors.primary,
    this.iconColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: AppBorderRadius.r8),
      child: Icon(icon, color: iconColor),
    );
  }
}
