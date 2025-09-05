import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_bookings_model.dart';
import 'package:gandhi_tvs/pages/allocate_chassis_page.dart';
import 'package:gandhi_tvs/pages/update_chassis_page.dart';

class CustomPopUpMenuButton extends StatelessWidget {
  const CustomPopUpMenuButton({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      color: Colors.white,
      onSelected: (value) {
        booking.status != "ALLOCATED"
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllocateChassisPage(booking: booking),
                ),
              )
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateChassisPage(booking: booking),
                ),
              );
      },
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            value: booking.status != "ALLOCATED"
                ? "Allocate Chassis"
                : "Update Chassis",
            child: Row(
              children: [
                Icon(Icons.directions_car, size: 20),
                SizedBox(width: 8),
                Text(
                  booking.status != "ALLOCATED"
                      ? "Allocate Chassis"
                      : "Update Chassis",
                ),
              ],
            ),
          ),
        ];
      },
    );
  }
}
