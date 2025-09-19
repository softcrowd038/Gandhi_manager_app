import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends HookWidget implements PreferredSizeWidget {
  final String? username;
  final void Function()? onTap;
  final void Function()? onTapLeading;

  const CustomAppBar({
    super.key,
    required this.username,
    required this.onTap,
    required this.onTapLeading,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final bookingsProvider = Provider.of<AllBookingsProvider>(
          context,
          listen: false,
        );

        bookingsProvider.getBookingsProvider(context, "PENDING_APPROVAL");

        final notificationProvider = Provider.of<GetNotificationProvider>(
          context,
          listen: false,
        );

        notificationProvider.getNotifications(context);
      });
      return null;
    }, []);

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,

      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png',
                height: height * 0.1,
                width: height * 0.1,
              ),
              SizedBox(width: height * 0.008),
              (username != 'User')
                  ? Text(
                      (username ?? 'USER').toUpperCase(),
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: height * 0.018,
                      ),
                    )
                  : Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: height * 0.12,
                        height: height * 0.018,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GetModelDetailsByScanning(),
                    ),
                  );
                },
                child: Image.network(
                  'https://cdn-icons-png.flaticon.com/128/15471/15471832.png',
                  height: height * 0.03,
                  width: height * 0.03,
                ),
              ),
              SizedBox(width: AppDimensions.width2),
              GestureDetector(
                onTap: onTap,
                child: Image.asset(
                  'assets/images/power.png',
                  height: height * 0.03,
                  width: height * 0.03,
                ),
              ),
              SizedBox(width: AppDimensions.width2),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GetNotificationsUpdates(),
                    ),
                  );
                },
                child: Consumer<UserDetailsProvider>(
                  builder: (context, userDetails, _) {
                    return userDetails.userDetails?.data?.roles.any(
                              (role) => role.name == "MANAGER",
                            ) ??
                            true
                        ? Stack(
                            children: [
                              Image.asset(
                                'assets/images/notif.png',
                                height: height * 0.03,
                                width: height * 0.03,
                              ),
                              Positioned(
                                left: 8,
                                top: -2,
                                child: ClipRRect(
                                  borderRadius: AppBorderRadius.r2,
                                  child: Container(
                                    height: AppDimensions.height2,
                                    width: AppDimensions.height2,
                                    decoration: BoxDecoration(
                                      color: AppColors.surface,
                                      borderRadius: AppBorderRadius.r2,
                                    ),
                                    // child: Consumer<GetNotificationProvider>(
                                    //   builder: (context, bookingsProvider, _) {
                                    //     print(
                                    //       bookingsProvider
                                    //           .notificationModel
                                    //           ?.notificationSummary
                                    //           .totalPending
                                    //           .toString(),
                                    //     );
                                    //     return Center(
                                    //       child: Text(
                                    //         bookingsProvider
                                    //                 .notificationModel
                                    //                 ?.notificationSummary
                                    //                 .totalPending
                                    //                 .toString() ??
                                    //             "0",
                                    //         style: TextStyle(
                                    //           fontSize: AppFontSize.s16,
                                    //           color: AppColors.error,
                                    //           fontWeight: AppFontWeight.w600,
                                    //         ),
                                    //       ),
                                    //     );
                                    //   },
                                    // ),
                                    child: Center(
                                      child: Text(
                                        "10",
                                        style: TextStyle(
                                          fontSize: AppFontSize.s16,
                                          color: AppColors.error,
                                          fontWeight: AppFontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
