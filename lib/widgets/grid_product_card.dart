import 'package:gandhi_tvs/common/app_imports.dart';

class GridProductCard extends HookWidget {
  final String image;
  final String modelName;
  final String colorName;
  final Color color;
  final String price;

  const GridProductCard({
    super.key,
    required this.modelName,
    required this.image,
    required this.color,
    required this.colorName,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.p2,
      child: Container(
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
                  Icon(
                    Icons.circle,
                    color: color,
                    size: MediaQuery.of(context).size.height * 0.016,
                  ),
                  SizedBox(width: 4),
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
          ],
        ),
      ),
    );
  }
}
