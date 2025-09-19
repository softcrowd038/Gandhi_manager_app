import 'package:gandhi_tvs/common/app_imports.dart' hide Datum;
import 'package:gandhi_tvs/models/get_notification_model.dart';
import 'package:provider/provider.dart';

class GetNotificationsUpdates extends HookWidget {
  const GetNotificationsUpdates({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
      ),
      body: _BookingsTab(
        status: "PENDING_APPROVAL",
        tabName: "Pending Approval",
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
    final allBookingsProvider = Provider.of<GetNotificationProvider>(context);
    final financeLetterProvider = Provider.of<FinanceLetterProvider>(
      context,
      listen: false,
    );
    final isLoading = useState<bool>(false);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isLoading.value = true;
        allBookingsProvider.getNotifications(context).then((_) {
          isLoading.value = false;
        });
      });
      return null;
    }, []);

    return Column(
      children: [
        // Add notification summary header
        if (allBookingsProvider.notificationModel?.notificationSummary != null)
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Row(
              children: [
                Icon(Icons.notifications, color: AppColors.primary),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    allBookingsProvider
                            .notificationModel!
                            .notificationSummary
                            .message ??
                        "",
                    style: TextStyle(
                      fontSize: AppFontSize.s16,
                      fontWeight: AppFontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        Expanded(
          child: isLoading.value
              ? Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                )
              : allBookingsProvider.notificationModel == null ||
                    allBookingsProvider.notificationModel!.data.isEmpty
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
              : _BookingsList(
                  bookings: allBookingsProvider.notificationModel!,
                  financeLetterProvider: financeLetterProvider,
                ),
        ),
      ],
    );
  }
}

class _BookingsList extends StatelessWidget {
  final GetNotificationMOdel bookings;
  final FinanceLetterProvider financeLetterProvider;

  const _BookingsList({
    required this.bookings,
    required this.financeLetterProvider,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bookings.data.length,
      itemBuilder: (context, index) {
        return _BookingListItem(
          booking: bookings.data[index],
          financeLetterProvider: financeLetterProvider,
        );
      },
    );
  }
}

class _BookingListItem extends StatelessWidget {
  final Datum booking;
  final FinanceLetterProvider financeLetterProvider;

  const _BookingListItem({
    required this.booking,
    required this.financeLetterProvider,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: AppColors.surface,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          "#${booking.bookingNumber}",
          style: TextStyle(
            fontSize: AppFontSize.s18,
            fontWeight: AppFontWeight.w600,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              booking.customMessage ?? "",
              style: TextStyle(
                fontSize: AppFontSize.s14,
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Created by: ',
                  style: TextStyle(
                    fontSize: AppFontSize.s16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  booking.createdByName ?? "",
                  style: TextStyle(
                    fontSize: AppFontSize.s16,

                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),

        leading: UserIconContainer(),
      ),
    );
  }
}
