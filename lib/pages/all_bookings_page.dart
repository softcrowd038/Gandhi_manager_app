// ignore_for_file: deprecated_member_use, unrelated_type_equality_checks
import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_bookings_model.dart';
import 'package:gandhi_tvs/widgets/booking_status_container.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AllBookingsPage extends HookWidget {
  const AllBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchController = useTextEditingController();
    final filteredBookings = useState<List<Booking>>([]);
    final allBookingsProvider = Provider.of<AllBookingsProvider>(context);
    final financeLetterProvider = Provider.of<FinanceLetterProvider>(
      context,
      listen: false,
    );

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        allBookingsProvider.getBookingsProvider(context);
      });
      return null;
    }, []);

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

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SearchField(
            controller: searchController,
            onChanged: (query) => filterBookings(query),
            labelText: "Search customer by name",
          ),
          Expanded(
            child: allBookingsProvider.isLoading ?? false
                ? Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  )
                : filteredBookings.value.isEmpty
                ? Center(
                    child: Text(
                      "No bookings found",
                      style: TextStyle(
                        fontSize: AppFontSize.s18,
                        fontWeight: AppFontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredBookings.value.length,
                    itemBuilder: (context, index) {
                      final booking = filteredBookings.value[index];

                      print(booking.status);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GetBookingByIdPage(
                                bookingId: booking.bookingId,
                              ),
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
                                    DateFormat('yyyy-MM-dd').format(
                                      booking.createdAt ?? DateTime.now(),
                                    ),
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
                                  Expanded(
                                    child: StatusChangeContainer(
                                      label: "FL",
                                      status1: booking.financeLetterStatus
                                          .toString(),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: AppDimensions.height1),
                              BookingStatusContainer(
                                label: booking.status.toString(),
                                status1: booking.status.toString(),
                              ),
                            ],
                          ),
                          leading: UserIconContainer(),
                          trailing: CustomPopUpMenuButton(
                            booking: booking,
                            financeLetterProvider: financeLetterProvider,
                            status1: booking.financeLetterStatus.toString(),
                            status2: booking.kycStatus.toString(),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
