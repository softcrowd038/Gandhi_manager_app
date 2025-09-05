// import 'package:gandhi_tvs/common/app_imports.dart';
// import 'package:gandhi_tvs/models/all_bookings_model.dart';
// import 'package:gandhi_tvs/widgets/booking_status_container.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

// class BookingListItem extends StatelessWidget {
//   final Booking booking;

//   const BookingListItem({super.key, required this.booking});

//   @override
//   Widget build(BuildContext context) {
//     final financeLetterProvider = Provider.of<FinanceLetterProvider>(
//       context,
//       listen: false,
//     );

//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) =>
//                 GetBookingByIdPage(bookingId: booking.bookingId),
//           ),
//         );
//       },
//       child: ListTile(
//         title: CustomNameAndStatus(booking: booking),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               booking.model.modelName,
//               style: TextStyle(fontSize: AppFontSize.s16),
//             ),
//             LableWithIcon(
//               lable: booking.bookingNumber,
//               colors: AppColors.error,
//               textColors: AppColors.primary,
//               circle: Icons.circle,
//               size: AppDimensions.height1,
//               fontWeight: AppFontWeight.bold,
//             ),
//             Row(
//               children: [
//                 Text(
//                   DateFormat(
//                     'yyyy-MM-dd',
//                   ).format(booking.createdAt ?? DateTime.now()),
//                   style: TextStyle(
//                     color: Colors.black38,
//                     fontSize: AppFontSize.s14,
//                     fontWeight: AppFontWeight.w300,
//                   ),
//                 ),
//                 SizedBox(width: AppDimensions.width5),
//                 Expanded(
//                   child: StatusChangeContainer(
//                     label: "Kyc",
//                     status1: booking.kycStatus.toString(),
//                   ),
//                 ),
//                 SizedBox(width: AppDimensions.width5),
//                 Expanded(
//                   child: StatusChangeContainer(
//                     label: "FL",
//                     status1: booking.financeLetterStatus.toString(),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: AppDimensions.height1),
//             BookingStatusContainer(
//               label: booking.status.toString(),
//               status1: booking.status.toString(),
//             ),
//           ],
//         ),
//         leading: const UserIconContainer(), // Make const if possible
//         trailing: CustomPopUpMenuButton(
//           booking: booking,
//           financeLetterProvider: financeLetterProvider,
//           status1: booking.financeLetterStatus.toString(),
//           status2: booking.kycStatus.toString(),
//         ),
//       ),
//     );
//   }
// }
