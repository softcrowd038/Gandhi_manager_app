// ignore_for_file: deprecated_member_use

import 'package:gandhi_tvs/common/app_imports.dart';

class CustomerHeader extends StatelessWidget {
  final String customerName;
  final String address;
  final String bookingId;

  const CustomerHeader({
    super.key,
    required this.customerName,
    required this.address,
    required this.bookingId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(left: AppDimensions.height2),
          child: Container(
            height: AppDimensions.height8,
            width: AppDimensions.height8,
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
          ),
        ),
        SizedBox(width: AppDimensions.height2),
        Expanded(
          // Added Expanded to constrain text width
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: AppDimensions.height2),
                child: Text(
                  customerName.toUpperCase(),
                  style: TextStyle(
                    fontSize: AppFontSize.s20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                  maxLines: 2, // Limit to 2 lines
                  overflow: TextOverflow.ellipsis, // Show ellipsis if overflow
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: AppDimensions.height2),
                child: Text(
                  address,
                  style: TextStyle(
                    fontSize: AppFontSize.s16,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                  ),
                  maxLines: 3, // Increased to 3 lines for longer addresses
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: AppDimensions.height2),
                child: Text(
                  bookingId,
                  style: TextStyle(
                    fontSize: AppFontSize.s16,
                    fontWeight: FontWeight.w300,
                    color: Colors.red,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
