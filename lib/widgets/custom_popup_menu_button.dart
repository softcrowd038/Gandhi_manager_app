import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_bookings_model.dart';

class CustomPopUpMenuButton extends StatelessWidget {
  const CustomPopUpMenuButton({
    super.key,
    required this.booking,
    required this.financeLetterProvider,
    required this.status1,
    required this.status2,
  });

  final Booking booking;
  final FinanceLetterProvider financeLetterProvider;
  final Status? status1;
  final Status? status2;

  String _getFinanceLetterLabel() {
    switch (status1) {
      case Status.PENDING:
        return "Uploaded Finance Letter";
      case Status.APPROVED:
        return "Approved Finance Letter";
      case Status.NOT_UPLOADED:
      default:
        return "Add Finance Letter";
    }
  }

  String _getKycLabel() {
    switch (status2) {
      case Status.PENDING:
        return "Uploaded KYC";
      case Status.APPROVED:
        return "Approved KYC";
      case Status.NOT_UPLOADED:
      default:
        return "Add KYC Details";
    }
  }

  bool _isFinanceLetterEnabled() =>
      status1 == Status.NOT_UPLOADED || status1 == null;

  bool _isKycEnabled() => status2 == Status.NOT_UPLOADED || status2 == null;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      color: Colors.white,
      onSelected: (value) {
        if (value == 'Add Finance Letter') {
          showFinanceLetterDialog(
            context: context,
            customerName:
                "${booking.customerDetails?.salutation} ${booking.customerDetails?.name}",
            financeLetterProvider: financeLetterProvider,
            bookingId: booking.bookingId,
          );
        } else if (value == 'Add KYC Details') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerKyc(
                address: booking.customerDetails?.address ?? "",
                bookingId: booking.bookingId ?? "",
                customerName:
                    "${booking.customerDetails?.salutation} ${booking.customerDetails?.name}",
              ),
            ),
          );
        }
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: _isFinanceLetterEnabled() ? "Add Finance Letter" : "",
          enabled: _isFinanceLetterEnabled(),
          child: Text(_getFinanceLetterLabel()),
        ),
        PopupMenuItem(
          value: _isKycEnabled() ? "Add KYC Details" : "",
          enabled: _isKycEnabled(),
          child: Text(_getKycLabel()),
        ),
      ],
    );
  }
}
