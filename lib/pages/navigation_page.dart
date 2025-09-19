// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison
import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

class NavigationPage extends HookWidget {
  NavigationPage({super.key, required this.index});

  final int index;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final selectedIndex = useState(index);
    final userDetailsProvider = context.watch<UserDetailsProvider>();
    final isLoading = useState(true);

    useEffect(() {
      Future.microtask(() async {
        await context.read<UserDetailsProvider>().fetchUserDetails(context);
        isLoading.value = false;
      });

      return null;
    }, const []);

    final username = userDetailsProvider.userDetails?.data?.name ?? 'User';

    final pages = isLoading.value
        ? [MyHomePage()]
        : [
            MyHomePage(),
            ActivityPage(isActivePage: true),
            BikeModelsDetails(),
            AllBookingsPage(),
            ApprovedBookingsPage(),

            // (userDetailsProvider.userDetails?.data?.roles.any(
            //           (role) => role.name == "MANAGER",
            //         ) ??
            //         false)
            //     ? ApprovedBookingsPage()
            //     : null,
          ].where((page) => page != null).cast<Widget>().toList();
    final navItems = isLoading.value
        ? [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: SizeConfig.screenHeight * 0.025),
              label: "Home",
            ),
          ]
        : [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: SizeConfig.screenHeight * 0.025),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_repair_service,
                    size: SizeConfig.screenHeight * 0.025,
                  ),
                  label: "Quotations",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.bike_scooter,
                    size: SizeConfig.screenHeight * 0.025,
                  ),
                  label: "Models",
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.file),
                  label: "Bookings",
                ),
                // Ternary instead of if condition
                // (userDetailsProvider.userDetails?.data?.roles.any(
                //           (role) => role.name == "MANAGER",
                //         ) ??
                //         false)
                //     ? BottomNavigationBarItem(
                //         icon: Icon(Icons.verified),
                //         label: "Allocate",
                //       )
                //     : null,
                BottomNavigationBarItem(
                  icon: Icon(Icons.verified),
                  label: "Allocate",
                ),
              ]
              .where((item) => item != null)
              .cast<BottomNavigationBarItem>()
              .toList();

    void onItemTapped(int index) {
      if (index < pages.length) {
        selectedIndex.value = index;
      } else {
        selectedIndex.value = 0;
      }
    }

    Future<void> handleLogout() async {
      final shouldLogout = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        },
      );

      if (shouldLogout == true) {
        removeAuthToken(context);
      }
    }

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.surface,
      appBar: CustomAppBar(
        username: username,
        onTap: handleLogout,
        onTapLeading: () {
          _scaffoldKey.currentState?.openDrawer();
        },
      ),
      body: userDetailsProvider.isLoading || isLoading.value
          ? Center(child: CircularProgressIndicator(color: AppColors.primary))
          : pages[selectedIndex.value],
      bottomNavigationBar: isLoading.value
          ? null
          : BottomNavigationBar(
              currentIndex: selectedIndex.value.clamp(0, navItems.length - 1),
              backgroundColor: AppColors.surface,
              elevation: 2,
              onTap: onItemTapped,
              selectedItemColor: Color(0xFF4965e9),
              unselectedItemColor: Colors.black54,
              items: navItems,
            ),
    );
  }
}
