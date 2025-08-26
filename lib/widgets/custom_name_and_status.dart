import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_bookings_model.dart';

class CustomNameAndStatus extends StatelessWidget {
  const CustomNameAndStatus({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${booking.customerDetails.salutation} ${booking.customerDetails.name}",
      style: TextStyle(
        fontWeight: AppFontWeight.w600,
        fontSize: AppFontSize.s18,
      ),
    );
  }
}
