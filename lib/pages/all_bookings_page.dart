// ignore_for_file: deprecated_member_use, unrelated_type_equality_checks
import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_bookings_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllBookingsPage extends HookWidget {
  const AllBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          automaticallyImplyLeading: false,
          title: TabBar(
            tabs: [
              Tab(text: 'Pending Approval'),
              Tab(text: 'Discount Exceeded'),
            ],
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: TabBarView(
          children: [
            _BookingsTab(
              status: "PENDING_APPROVAL",
              tabName: "Pending Approval",
            ),
            _BookingsTab(
              status: "PENDING_APPROVAL (Discount_Exceeded)",
              tabName: "Discount Exceeded",
            ),
          ],
        ),
      ),
    );
  }
}

class _BookingsTab extends StatefulWidget {
  final String status;
  final String tabName;

  const _BookingsTab({required this.status, required this.tabName});

  @override
  State<_BookingsTab> createState() => __BookingsTabState();
}

class __BookingsTabState extends State<_BookingsTab> {
  final searchController = TextEditingController();
  List<Booking> filteredBookings = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadBookings();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _loadBookings() async {
    if (mounted) {
      setState(() => isLoading = true);
    }

    final allBookingsProvider = Provider.of<AllBookingsProvider>(
      context,
      listen: false,
    );

    await allBookingsProvider.getBookingsProvider(context, widget.status);

    if (mounted) {
      setState(() {
        isLoading = false;
        final bookings =
            allBookingsProvider.allBookingsModel?.data.bookings ?? [];
        filteredBookings = bookings;
      });
    }
  }

  void filterBookings(String query) {
    final allBookingsProvider = Provider.of<AllBookingsProvider>(
      context,
      listen: false,
    );
    final allBookings =
        allBookingsProvider.allBookingsModel?.data.bookings ?? [];

    if (query.isEmpty) {
      setState(() => filteredBookings = allBookings);
    } else {
      final queryLower = query.toLowerCase();
      final filtered = allBookings.where((booking) {
        return booking.customerDetails.mobile1?.toLowerCase().contains(
                  queryLower,
                ) ==
                true ||
            booking.bookingNumber?.toLowerCase().contains(queryLower) == true ||
            booking.chassisNumber?.toLowerCase().contains(queryLower) == true ||
            booking.customerDetails.name?.toLowerCase().contains(queryLower) ==
                true;
      }).toList();

      setState(() => filteredBookings = filtered);
    }
  }

  @override
  Widget build(BuildContext context) {
    final financeLetterProvider = Provider.of<FinanceLetterProvider>(
      context,
      listen: false,
    );

    return Column(
      children: [
        SizedBox(height: AppDimensions.height1),
        SearchField(
          controller: searchController,
          onChanged: filterBookings,
          labelText: "Search ${widget.tabName} bookings",
        ),
        Expanded(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : filteredBookings.isEmpty
              ? Center(
                  child: Text(
                    "No ${widget.tabName} bookings found",
                    style: TextStyle(
                      fontSize: AppFontSize.s18,
                      fontWeight: AppFontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                )
              : _BookingsList(
                  bookings: filteredBookings,
                  financeLetterProvider: financeLetterProvider,
                ),
        ),
      ],
    );
  }
}

class _BookingsList extends StatelessWidget {
  final List<Booking> bookings;
  final FinanceLetterProvider financeLetterProvider;

  const _BookingsList({
    required this.bookings,
    required this.financeLetterProvider,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return _BookingListItem(
          booking: booking,
          financeLetterProvider: financeLetterProvider,
        );
      },
    );
  }
}

class _BookingListItem extends StatelessWidget {
  final Booking booking;
  final FinanceLetterProvider financeLetterProvider;

  const _BookingListItem({
    required this.booking,
    required this.financeLetterProvider,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                GetBookingByIdPage(bookingId: booking.bookingId),
          ),
        );
      },
      child: ListTile(
        title: CustomNameAndStatus(booking: booking),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              booking.model.modelName ?? "",
              style: TextStyle(fontSize: AppFontSize.s16),
            ),
            LableWithIcon(
              lable: booking.bookingNumber,
              colors: AppColors.error,
              textColors: AppColors.primary,
              circle: Icons.circle,
              size: AppDimensions.height1,
              fontWeight: AppFontWeight.bold,
            ),
            Row(
              children: [
                Text(
                  DateFormat(
                    'yyyy-MM-dd',
                  ).format(booking.createdAt ?? DateTime.now()),
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: AppFontSize.s14,
                    fontWeight: AppFontWeight.w300,
                  ),
                ),
                SizedBox(width: AppDimensions.width5),
                Expanded(
                  child: StatusChangeContainer(
                    label: "Kyc",
                    status1: booking.kycStatus.toString(),
                  ),
                ),
                SizedBox(width: AppDimensions.width5),
                booking.payment.type == "FINANCE"
                    ? Expanded(
                        child: StatusChangeContainer(
                          label: "FL",
                          status1: booking.financeLetterStatus.toString(),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
            SizedBox(height: AppDimensions.height1),
            Consumer<UserDetailsProvider>(
              builder: (context, userDetails, _) {
                return userDetails.userDetails?.data?.roles.any(
                          (role) => role.name == "MANAGER",
                        ) ??
                        true
                    ? BookingStatusContainer(
                        label: booking.status.toString(),
                        status1: booking.status.toString(),
                      )
                    : SizedBox.shrink();
              },
            ),
          ],
        ),
        leading: UserIconContainer(),
        trailing: CustomPopUpMenuButtonForVerification(
          booking: booking,
          financeLetterProvider: financeLetterProvider,
          status1: booking.financeLetterStatus.toString(),
          status2: booking.kycStatus.toString(),
          downPaymentStatus: booking.financeLetterStatus,
        ),
      ),
    );
  }
}
