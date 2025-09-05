import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_bookings_model.dart';
import 'package:gandhi_tvs/pages/add_downpayment_page.dart';
import 'package:gandhi_tvs/pages/verify_finance_letter.dart';
import 'package:gandhi_tvs/pages/verify_kyc_page.dart';
import 'package:gandhi_tvs/pages/verify_pending_request.dart';
import 'package:provider/provider.dart';

class CustomPopUpMenuButtonForVerification extends StatefulWidget {
  const CustomPopUpMenuButtonForVerification({
    super.key,
    required this.booking,
    required this.financeLetterProvider,
    required this.status1,
    required this.status2,
    this.downPaymentStatus,
  });

  final Booking booking;
  final FinanceLetterProvider financeLetterProvider;
  final String? status1;
  final String? status2;
  final String? downPaymentStatus;

  @override
  State<CustomPopUpMenuButtonForVerification> createState() =>
      _CustomPopUpMenuButtonForVerificationState();
}

class _CustomPopUpMenuButtonForVerificationState
    extends State<CustomPopUpMenuButtonForVerification> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userDetailsProvider = Provider.of<UserDetailsProvider>(
        context,
        listen: false,
      );
      userDetailsProvider.fetchUserDetails(context);
    });
  }

  String _getFinanceLetterLabel() {
    switch (widget.status1) {
      case "PENDING":
        return "View Finance Letter (Pending)";
      case "APPROVED":
        return "View Finance Letter (Approved)";
      case "REJECTED":
        return "View Finance Letter (Rejected)";
      case "NOT_UPLOADED":
      default:
        return "Upload Finance Letter";
    }
  }

  String _getKycLabel() {
    switch (widget.status2) {
      case "PENDING":
        return "View KYC (Pending)";
      case "APPROVED":
        return "View KYC (Approved)";
      case "REJECTED":
        return "View KYC (Rejected)";
      case "NOT_UPLOADED":
      default:
        return "Upload KYC Details";
    }
  }

  bool _isFinanceLetterEnabled() {
    switch (widget.status1) {
      case "NOT_UPLOADED":
      case "PENDING":
      case "REJECTED":
      case "APPROVED":
        return true;
      default:
        return false;
    }
  }

  bool _isKycEnabled() {
    switch (widget.status2) {
      case "NOT_UPLOADED":
      case "PENDING":
      case "REJECTED":
      case "APPROVED":
        return true;
      default:
        return false;
    }
  }

  void _handleFinanceLetterAction(
    BuildContext context,
    UserDetailsProvider userDetails,
  ) {
    if (widget.status1 == "NOT_UPLOADED") {
      // Show upload dialog for finance letter
      showFinanceLetterDialog(
        context: context,
        customerName:
            "${widget.booking.customerDetails.salutation} ${widget.booking.customerDetails.name}",
        financeLetterProvider: widget.financeLetterProvider,
        bookingId: widget.booking.id ?? "",
      );
    } else if (userDetails.userDetails?.data?.roles.any(
          (role) => role.name == "MANAGER",
        ) ??
        true) {
      // Navigate to view page for other statuses
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              VerifyFinanceLetter(bookingId: widget.booking.id),
        ),
      );
    }
  }

  void _handleKycAction(BuildContext context, UserDetailsProvider userDetails) {
    if (widget.status2 == "NOT_UPLOADED") {
      // Navigate to KYC upload page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomerKyc(
            address: widget.booking.customerDetails.address ?? "",
            bookingId: widget.booking.id ?? "",
            customerName:
                "${widget.booking.customerDetails.salutation} ${widget.booking.customerDetails.name}",
          ),
        ),
      );
    } else if (userDetails.userDetails?.data?.roles.any(
          (role) => role.name == "MANAGER",
        ) ??
        true) {
      // Navigate to KYC view page for other statuses
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyKycPage(bookingId: widget.booking.id),
        ),
      );
    }
  }

  String _getDownPaymentLabel() {
    switch (widget.downPaymentStatus) {
      case "PENDING":
        return "Uploaded Downpayment";
      case "APPROVED":
        return "Approved Downpayment";
      case "NOT_UPLOADED":
      default:
        return "Add Downpayment";
    }
  }

  String _getPendingRequestLable() {
    switch (widget.booking.updateRequestStatus) {
      case "PENDING":
        return "Verify Pending Request";
      case "APPROVED":
        return "Approved Pending Request";
      case "REJECTED":
        return "Rejected Pending Request";
      case "NONE":
      default:
        return "Verify Pending Request";
    }
  }

  bool _isDownPaymentEnabled() =>
      widget.downPaymentStatus == "NOT_UPLOADED" ||
      widget.downPaymentStatus == null;

  bool _isPendingRequestEnabled() =>
      widget.booking.updateRequestStatus == "PENDING";

  @override
  Widget build(BuildContext context) {
    return Consumer<UserDetailsProvider>(
      builder: (context, userDetails, _) {
        return PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          color: Colors.white,
          onSelected: (value) {
            if (value == 'Upload Finance Letter' ||
                value.startsWith('View Finance Letter')) {
              _handleFinanceLetterAction(context, userDetails);
            } else if (value == 'Upload KYC Details' ||
                value.startsWith('View KYC')) {
              _handleKycAction(context, userDetails);
            } else if (value == 'Add Downpayment') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      AddDownpaymentPage(booking: widget.booking),
                ),
              );
            } else if (value == 'Verify Pending Request') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      VerifyPendingRequest(bookingId: widget.booking.bookingId),
                ),
              );
            }
          },
          itemBuilder: (BuildContext context) {
            final menuItems = <PopupMenuEntry<String>>[];

            // Finance Letter Item
            if (widget.booking.payment.type == "FINANCE") {
              menuItems.add(
                PopupMenuItem<String>(
                  value: _isFinanceLetterEnabled()
                      ? _getFinanceLetterLabel()
                      : null,
                  enabled: _isFinanceLetterEnabled(),
                  child: Text(_getFinanceLetterLabel()),
                ),
              );

              if (_isKycEnabled()) {
                menuItems.add(const PopupMenuDivider());
              }
            }

            // KYC Item
            menuItems.add(
              PopupMenuItem<String>(
                value: _isKycEnabled() ? _getKycLabel() : null,
                enabled: _isKycEnabled(),
                child: Text(_getKycLabel()),
              ),
            );

            if (widget.booking.payment.type == "FINANCE") {
              if (userDetails.userDetails?.data?.roles.any(
                    (role) => role.name == "MANAGER",
                  ) ??
                  true) {
                menuItems.add(
                  PopupMenuItem<String>(
                    value: _isDownPaymentEnabled() ? "Add Downpayment" : null,
                    enabled: _isDownPaymentEnabled(),
                    child: Text(_getDownPaymentLabel()),
                  ),
                );
              }
            }
            if (widget.booking.updateRequestStatus == "PENDING") {
              if (userDetails.userDetails?.data?.roles.any(
                    (role) => role.name == "MANAGER",
                  ) ??
                  true) {
                menuItems.add(
                  PopupMenuItem<String>(
                    value: _isPendingRequestEnabled()
                        ? "Verify Pending Request"
                        : null,
                    enabled: _isPendingRequestEnabled(),
                    child: Text(_getPendingRequestLable()),
                  ),
                );
              }
            }
            return menuItems;
          },
        );
      },
    );
  }
}
