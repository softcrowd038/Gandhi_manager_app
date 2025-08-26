import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/dash_stats_model.dart';
import 'package:provider/provider.dart';

class MyHomePage extends HookWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final monthlyStatProvider = Provider.of<GetMonthQuotations>(
          context,
          listen: false,
        );
        monthlyStatProvider.fetchMonthStatsofQuotations(context);
        final dailyStatProvider = Provider.of<GetTodayQuotations>(
          context,
          listen: false,
        );
        dailyStatProvider.fetchDayStatsofQuotations(context);
        final bikeModelProvider = Provider.of<BikeModelProvider>(
          context,
          listen: false,
        );
        bikeModelProvider.fetchBikeModels(context);

        final userProvider = Provider.of<UserDetailsProvider>(
          context,
          listen: false,
        );
        userProvider.fetchUserDetails(context);

        final dashProvider = Provider.of<DashStatsProvider>(
          context,
          listen: false,
        );
        dashProvider.getDashStats(context);
      });

      return null;
    }, []);

    return SafeArea(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:
                MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: height * 0.016),
                    child: Consumer<UserDetailsProvider>(
                      builder: (context, userDetailsProvider, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.check_circle_outline_rounded,
                              color: Colors.red,
                              size: AppDimensions.height2,
                            ),
                            SizedBox(width: AppDimensions.width1),
                            Text(
                              getCurrentMonthAndYear(),
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: AppFontSize.s16,
                                fontWeight: AppFontWeight.w600,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Selector<GetTodayQuotations, int>(
                        selector: (_, provider) =>
                            provider.quotation?.data?.count ?? 0,
                        builder: (context, count, child) {
                          return BuildStatCard(
                            title: "Quotations",
                            subTitle: 'Today',
                            value: count.toString(),
                            imageSource:
                                'https://cdn-icons-png.flaticon.com/128/17162/17162866.png',
                          );
                        },
                      ),
                      Selector<GetMonthQuotations, int>(
                        selector: (_, provider) =>
                            provider.quotation?.data?.count ?? 0,
                        builder: (context, count, child) {
                          return BuildStatCard(
                            title: "Quotations",
                            subTitle: 'This Month',
                            value: count.toString(),
                            imageSource:
                                'https://cdn-icons-png.flaticon.com/128/2693/2693710.png',
                          );
                        },
                      ),
                    ],
                  ),
                  Selector<DashStatsProvider, DashStatsModel?>(
                    selector: (_, p1) => p1.dashStatsModel,
                    builder: (context, dashStats, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BuildStatCard(
                            title: "Bookings",
                            subTitle: "Today",
                            value:
                                dashStats?.data.counts.today.toString() ?? "0",
                            imageSource:
                                "https://cdn-icons-png.flaticon.com/128/17645/17645470.png",
                          ),
                          BuildStatCard(
                            title: "Bookings",
                            subTitle: "This Month",
                            value:
                                dashStats?.data.counts.thisMonth.toString() ??
                                "0",
                            imageSource:
                                "https://cdn-icons-png.flaticon.com/128/1827/1827319.png",
                          ),
                        ],
                      );
                    },
                  ),
                  Selector<DashStatsProvider, DashStatsModel?>(
                    selector: (_, p1) => p1.dashStatsModel,
                    builder: (context, dashStats, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BuildStatCard(
                            title: "FL",
                            subTitle: "This Week",
                            value:
                                dashStats
                                    ?.data
                                    .pendingDocuments
                                    .financeLetter
                                    .thisWeek
                                    .toString() ??
                                "0",
                            imageSource:
                                "https://cdn-icons-png.flaticon.com/128/13163/13163401.png",
                          ),
                          BuildStatCard(
                            title: "FL",
                            subTitle: "This Month",
                            value:
                                dashStats
                                    ?.data
                                    .pendingDocuments
                                    .financeLetter
                                    .thisMonth
                                    .toString() ??
                                "0",
                            imageSource:
                                "https://cdn-icons-png.flaticon.com/128/3491/3491321.png",
                          ),
                        ],
                      );
                    },
                  ),
                  Selector<DashStatsProvider, DashStatsModel?>(
                    selector: (_, p1) => p1.dashStatsModel,
                    builder: (context, dashStats, _) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BuildStatCard(
                            title: "KYC",
                            subTitle: "This week",
                            value:
                                dashStats?.data.pendingDocuments.kyc.thisWeek
                                    .toString() ??
                                "0",
                            imageSource:
                                "https://cdn-icons-png.flaticon.com/128/17442/17442782.png",
                          ),
                          BuildStatCard(
                            title: "KYC",
                            subTitle: "This Month",
                            value:
                                dashStats?.data.pendingDocuments.kyc.thisMonth
                                    .toString() ??
                                "0",
                            imageSource:
                                "https://cdn-icons-png.flaticon.com/128/13350/13350956.png",
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              SectionTitle(title: "Quick Actions"),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectModelPage(),
                          ),
                        );
                      },
                      child: QuickActionContainer(
                        imageUrl:
                            "https://cdn-icons-png.flaticon.com/128/781/781791.png",
                        action: "Generate Quotation",
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavigationPage(index: 1),
                          ),
                        );
                      },
                      child: QuickActionContainer(
                        imageUrl:
                            "https://cdn-icons-png.flaticon.com/128/7475/7475712.png",
                        action: "Export Quotation",
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavigationPage(index: 3),
                          ),
                        );
                      },
                      child: QuickActionContainer(
                        imageUrl:
                            "https://cdn-icons-png.flaticon.com/128/893/893214.png",
                        action: "Export Bookings",
                      ),
                    ),
                  ),
                  Expanded(
                    child: Selector<UserDetailsProvider, bool>(
                      selector: (_, provider) =>
                          provider.userDetails?.data?.isFrozen ?? false,
                      builder: (context, isFrozen, _) {
                        return GestureDetector(
                          onTap: () {
                            if (!isFrozen) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SelectBookingModelPage(),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: AppColors.error,
                                  content: Text(
                                    "Your Booking Module is Freezed",
                                  ),
                                ),
                              );
                            }
                          },
                          child: QuickActionContainer(
                            imageUrl:
                                "https://cdn-icons-png.flaticon.com/128/2173/2173550.png",
                            action: "Book a Bike",
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppDimensions.height1),
              Padding(padding: AppPadding.p2, child: BannerWidget()),
              SectionTitle(title: "Stock Statistics"),
              Padding(
                padding: AppPadding.p2,
                child: Container(
                  width: AppDimensions.fullWidth,
                  decoration: BoxDecoration(
                    borderRadius: AppBorderRadius.r2,
                    color: Colors.white,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Selector<BikeModelProvider, int>(
                        selector: (_, provider) =>
                            provider.bikeModels?.data?.models.length ?? 0,
                        builder: (context, modelCount, child) {
                          return SizeChangingContainer(
                            icon:
                                "https://cdn-icons-png.flaticon.com/128/8343/8343680.png",
                            title: "Models",
                            value: modelCount.toString(),
                            width: MediaQuery.of(context).size.width * 0.75,
                            color: AppColors.primary,
                            textColor: Colors.white,
                          );
                        },
                      ),
                      SizeChangingContainer(
                        icon:
                            "https://cdn-icons-png.flaticon.com/128/8091/8091495.png",
                        title: "Inwarded Models",
                        value: "45",
                        width: MediaQuery.of(context).size.width * 0.85,
                        color: AppColors.background,
                        textColor: AppColors.textPrimary,
                      ),
                      SizeChangingContainer(
                        icon:
                            "https://cdn-icons-png.flaticon.com/128/4764/4764147.png",
                        title: "Pending Collections",
                        value: "12",
                        width: MediaQuery.of(context).size.width * 0.9,
                        color: AppColors.primary,
                        textColor: Colors.white,
                      ),
                      SizeChangingContainer(
                        icon:
                            "https://cdn-icons-png.flaticon.com/128/4748/4748849.png",
                        title: "Pending Insurance Docs",
                        value: "28",
                        width: MediaQuery.of(context).size.width * 1,
                        color: AppColors.background,
                        textColor: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: AppDimensions.height50,
                child: ActivityPage(isActivePage: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
