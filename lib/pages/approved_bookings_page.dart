// ignore_for_file: deprecated_member_use, unrelated_type_equality_checks
import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_bookings_model.dart';
import 'package:gandhi_tvs/widgets/booking_status_container.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ApprovedBookingsPage extends HookWidget {
  const ApprovedBookingsPage({super.key});

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
              Tab(text: 'Approved'),
              Tab(text: 'Allocated'),
            ],
            indicatorColor: AppColors.primary,
            labelColor: AppColors.primary,
            unselectedLabelColor: Colors.grey,
          ),
        ),
        body: TabBarView(
          children: [
            _BookingsTab(status: "APPROVED", tabName: "Approved"),
            _BookingsTab(status: "ALLOCATED", tabName: "Allocated"),
          ],
        ),
      ),
    );
  }
}

class _BookingsTab extends HookWidget {
  final String status;
  final String tabName;

  const _BookingsTab({required this.status, required this.tabName});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final filteredBookings = useState<List<Booking>>([]);
    final allBookingsProvider = Provider.of<AllBookingsProvider>(context);
    final isLoading = useState<bool>(false);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading.value = true;
        allBookingsProvider.getBookingsProvider(context, status).then((_) {
          isLoading.value = false;
        });
      });
      return null;
    }, [status]);

    useEffect(() {
      final bookings =
          allBookingsProvider.allBookingsModel?.data.bookings ?? [];
      filteredBookings.value = bookings;
      return null;
    }, [allBookingsProvider.allBookingsModel?.data.bookings]);

    void filterBookings(String query) {
      final allBookings =
          allBookingsProvider.allBookingsModel?.data.bookings ?? [];

      if (query.isEmpty) {
        filteredBookings.value = allBookings;
      } else {
        filteredBookings.value = allBookings
            .where(
              (booking) =>
                  booking.customerDetails.name?.toLowerCase().contains(
                    query.toLowerCase(),
                  ) ??
                  false,
            )
            .toList();
      }
    }

    return Column(
      children: [
        SizedBox(height: AppDimensions.height1),
        SearchField(
          controller: searchController,
          onChanged: filterBookings,
          labelText: "Search $tabName bookings by name",
        ),
        Expanded(
          child: isLoading.value
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : filteredBookings.value.isEmpty
              ? Center(
                  child: Text(
                    "No $tabName bookings found",
                    style: TextStyle(
                      fontSize: AppFontSize.s18,
                      fontWeight: AppFontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                )
              : _BookingsList(bookings: filteredBookings.value, status: status),
        ),
      ],
    );
  }
}

class _BookingsList extends StatelessWidget {
  final List<Booking> bookings;
  final String status;

  const _BookingsList({required this.bookings, required this.status});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return _BookingListItem(booking: booking);
      },
    );
  }
}

class _BookingListItem extends StatelessWidget {
  final Booking booking;

  const _BookingListItem({required this.booking});

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
              booking.model.modelName,
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
        trailing: CustomPopUpMenuButton(booking: booking),
      ),
    );
  }
}
