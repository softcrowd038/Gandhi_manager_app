// ignore_for_file: deprecated_member_use

import 'package:gandhi_tvs/common/app_imports.dart';

class QuickActionContainer extends HookWidget {
  final String? imageUrl;
  final String? action;
  const QuickActionContainer({
    super.key,
    required this.imageUrl,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          height: AppDimensions.height6,
          width: AppDimensions.height6,
          decoration: BoxDecoration(
            color: AppColors.themeColor.withOpacity(0.2),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.themeColor, width: 1),
          ),
          child: Center(
            child: imageUrl != null
                ? ClipOval(
                    child: Image.network(
                      imageUrl!,
                      height: AppDimensions.height4,
                      width: AppDimensions.height4,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.image_not_supported,
                        color: AppColors.themeColor,
                      ),
                    ),
                  )
                : Icon(
                    Icons.bolt,
                    size: AppDimensions.height4,
                    color: AppColors.primary,
                  ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          action ?? "Action",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: AppFontSize.s14,
            fontWeight: AppFontWeight.w600,
          ),
        ),
      ],
    );
  }
}
