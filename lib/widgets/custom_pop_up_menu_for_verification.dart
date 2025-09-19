// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_bookings_model.dart';
import 'package:provider/provider.dart';

class CustomPopUpMenuButtonForVerification extends StatefulWidget {
  const CustomPopUpMenuButtonForVerification({
    super.key,
    required this.booking,
    required this.financeLetterProvider,
    required this.status1,
    required this.status2,
    this.downPaymentStatus,
    this.onBookingDeleted,
  });

  final Booking booking;
  final FinanceLetterProvider financeLetterProvider;
  final String? status1;
  final String? status2;
  final String? downPaymentStatus;
  final VoidCallback? onBookingDeleted;

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
      if (mounted) {
        final userDetailsProvider = Provider.of<UserDetailsProvider>(
          context,
          listen: false,
        );
        userDetailsProvider.fetchUserDetails(context);
      }
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
      showFinanceLetterDialog(
        context: context,
        customerName:
            "${widget.booking.customerDetails.salutation} ${widget.booking.customerDetails.name}",
        financeLetterProvider: widget.financeLetterProvider,
        bookingId: widget.booking.id ?? "",
        isIndexThree: true,
      );
    } else if (userDetails.userDetails?.data?.roles.any(
          (role) => role.name == "MANAGER",
        ) ??
        true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyFinanceLetter(
            bookingId: widget.booking.id,
            isIndexThree: true,
          ),
        ),
      );
    }
  }

  void _handleKycAction(BuildContext context, UserDetailsProvider userDetails) {
    if (widget.status2 == "NOT_UPLOADED") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomerKyc(
            address: widget.booking.customerDetails.address ?? "",
            bookingId: widget.booking.id ?? "",
            customerName:
                "${widget.booking.customerDetails.salutation} ${widget.booking.customerDetails.name}",
            isIndexThree: true,
          ),
        ),
      );
    } else if (userDetails.userDetails?.data?.roles.any(
          (role) => role.name == "MANAGER",
        ) ??
        true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              VerifyKycPage(bookingId: widget.booking.id, isIndexThree: true),
        ),
      );
    }
  }

  String _getDownPaymentLabel() {
    switch (widget.downPaymentStatus) {
      case "PENDING":
        return "Added Downpayment";
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

  bool _isDeleteEnabled() {
    return widget.booking.status == "PENDING_APPROVAL" ||
        widget.booking.status == "PENDING_APPROVAL (Discount_Exceeded)";
  }

  void _handleDeleteBooking(BuildContext context) {
    final deleteProvider = Provider.of<DeleteBookingProvider>(
      context,
      listen: false,
    );

    final BuildContext currentContext = context;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text(
            'Are you sure you want to delete booking #${widget.booking.bookingId}? '
            'This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);

                showDialog(
                  context: currentContext,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return Center(child: CircularProgressIndicator());
                  },
                );

                bool success = await deleteProvider.deleteBookingById(
                  currentContext,
                  widget.booking.id,
                );

                Navigator.pop(currentContext);

                if (success) {
                  if (widget.onBookingDeleted != null) {
                    widget.onBookingDeleted!();
                  }
                }
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserDetailsProvider, DeleteBookingProvider>(
      builder: (context, userDetails, deleteProvider, _) {
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
            } else if (value == 'Delete Booking') {
              _handleDeleteBooking(context);
            }
          },
          itemBuilder: (BuildContext context) {
            final menuItems = <PopupMenuEntry<String>>[];

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

            if (_isDeleteEnabled()) {
              menuItems.add(const PopupMenuDivider());
              menuItems.add(
                PopupMenuItem<String>(
                  value: 'Delete Booking',

                  enabled: _isDeleteEnabled() && !deleteProvider.isLoading,
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: Colors.red, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Delete Booking',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              );
            }

            return menuItems;
          },
        );
      },
    );
  }
}
