import 'package:gandhi_tvs/common/app_imports.dart';

class Detailspage extends StatelessWidget {
  const Detailspage({
    super.key,
    required this.image,
    required this.modelName,
    required this.color,
    required this.iconSize,
    required this.colorName,
    required this.price,
    required this.description,
  });

  final String image;
  final String modelName;
  final Color color;
  final double iconSize;
  final String colorName;
  final String price;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppBorderRadius.r1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              image,
              fit: BoxFit.contain,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: AppPadding.p1,
            child: Divider(color: AppColors.divider),
          ),
          Padding(
            padding: AppPadding.p1,
            child: Text(
              modelName,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: AppFontSize.s18,
                fontWeight: AppFontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: AppPadding.p1,
            child: Row(
              children: [
                Icon(Icons.circle, color: color, size: iconSize),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    colorName,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppFontSize.s16,
                      fontWeight: AppFontWeight.w300,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: AppPadding.p1,
            child: Text(
              price,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: AppFontSize.s16,
                fontWeight: AppFontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: AppDimensions.height1),
          Padding(
            padding: AppPadding.p2,
            child: Text(
              description,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: AppFontSize.s16,
                fontWeight: AppFontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
