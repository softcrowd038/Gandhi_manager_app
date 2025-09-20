// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_bookings_model.dart';
import 'package:provider/provider.dart';

class CustomPopUpMenuButton extends StatefulWidget {
  const CustomPopUpMenuButton({
    super.key,
    required this.booking,
    required this.financeLetterProvider,
    required this.downPaymentStatus,
  });

  final Booking booking;
  final FinanceLetterProvider financeLetterProvider;
  final String? downPaymentStatus;

  @override
  State<CustomPopUpMenuButton> createState() => _CustomPopUpMenuButtonState();
}

class _CustomPopUpMenuButtonState extends State<CustomPopUpMenuButton> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print(widget.booking.id);
      final getBookingByIdProvider = Provider.of<GetBookingsByIdProvider>(
        context,
        listen: false,
      );
      getBookingByIdProvider.reset();
      getBookingByIdProvider.fetchBookingsById(
        context,
        widget.booking.id ?? "",
      );
      final getDeclarations = Provider.of<GetDeclarationProvider>(
        context,
        listen: false,
      );
      getDeclarations.getDeclarations(context, "deal_form");

      final modelHeadersProvider = Provider.of<ModelHeadersProvider>(
        context,
        listen: false,
      );
      modelHeadersProvider.fetchModelHeaders(
        context,
        widget.booking.model.id ?? "",
      );

      final userDetailsProvider = Provider.of<UserDetailsProvider>(
        context,
        listen: false,
      );
      userDetailsProvider.fetchUserDetails(context);
    });
  }

  String _getFinanceLetterLabel() {
    switch (widget.booking.documentStatus.financeLetter.status) {
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
    switch (widget.booking.documentStatus.kyc.status) {
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
    if (widget.booking.payment.type != 'FINANCE') {
      return false;
    }

    switch (widget.booking.documentStatus.financeLetter.status) {
      case "NOT_UPLOADED":
      case "PENDING":
        return true;
      default:
        return false;
    }
  }

  bool _isKycEnabled() {
    switch (widget.booking.documentStatus.kyc.status) {
      case "NOT_UPLOADED":
      case "PENDING":
        return true;
      default:
        return false;
    }
  }

  Future<void> _saveAndOpenPdf(Uint8List pdfBytes, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/$fileName');

      await file.writeAsBytes(pdfBytes);

      await OpenFile.open(file.path);
    } catch (e) {
      debugPrint('Error saving/opening PDF: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to open PDF')));
    }
  }

  void _handleFinanceLetterAction(
    BuildContext context,
    UserDetailsProvider userDetails,
  ) {
    final financeLetterStatus =
        widget.booking.documentStatus.financeLetter.status;
    final userRoles = userDetails.userDetails?.data?.roles;

    if (financeLetterStatus == "NOT_UPLOADED") {
      showFinanceLetterDialog(
        context: context,
        customerName:
            "${widget.booking.customerDetails.salutation} ${widget.booking.customerDetails.name}",
        financeLetterProvider: widget.financeLetterProvider,
        bookingId: widget.booking.id ?? "",
        isIndexThree: false,
      );
    } else if (userRoles != null && userRoles.isNotEmpty) {
      if (financeLetterStatus == "PENDING") {
        final hasManagerRole = userRoles.any((role) => role.name == "MANAGER");
        if (hasManagerRole) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyFinanceLetter(
                bookingId: widget.booking.id ?? "",
                isIndexThree: false,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No access!!..'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
  }

  void _handleKycAction(BuildContext context, UserDetailsProvider userDetails) {
    final kycStatus = widget.booking.documentStatus.kyc.status;
    final userRoles = userDetails.userDetails?.data?.roles;

    if (kycStatus == "NOT_UPLOADED") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomerKyc(
            address: widget.booking.customerDetails.address ?? "",
            bookingId: widget.booking.id ?? "",
            customerName:
                "${widget.booking.customerDetails.salutation} ${widget.booking.customerDetails.name}",
            isIndexThree: false,
          ),
        ),
      );
    } else if (kycStatus == "PENDING") {
      if (userRoles != null && userRoles.isNotEmpty) {
        final hasManagerRole = userRoles.any((role) => role.name == "MANAGER");
        if (hasManagerRole) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerifyKycPage(
                bookingId: widget.booking.id ?? "",
                isIndexThree: false,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('No access!!..'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
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

  bool _isDownPaymentEnabled() =>
      widget.downPaymentStatus == "NOT_UPLOADED" ||
      widget.downPaymentStatus == null;

  @override
  Widget build(BuildContext context) {
    return Consumer5<
      GetDeclarationProvider,
      GetBookingsByIdProvider,
      GetHelmetDeclarationProvider,
      ModelHeadersProvider,
      UserDetailsProvider
    >(
      builder:
          (
            context,
            declarationProvider,
            bookingByIdProvider,
            helmetDeclaratProvider,
            modelHeadersProvider,
            userDetailsProvider,
            _,
          ) {
            return PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              color: Colors.white,
              onSelected: (value) async {
                if (value == "allocate_update") {
                  widget.booking.status != "ALLOCATED"
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AllocateChassisPage(booking: widget.booking),
                          ),
                        )
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdateChassisPage(booking: widget.booking),
                          ),
                        );
                } else if (value == "print_gst_invoice") {
                  bookingByIdProvider.reset();
                  await bookingByIdProvider.fetchBookingsById(
                    context,
                    widget.booking.id ?? "",
                  );

                  // Add a small delay to ensure state is updated
                  await Future.delayed(const Duration(milliseconds: 100));
                  GstInvoice.generatePdf(
                    bookingByIdProvider.bookings,
                    declarationProvider.declarationModel,
                    modelHeadersProvider
                            .modelHeaders
                            ?.data
                            ?.model
                            .prices[0]
                            .metadata
                            ?.gstRate ??
                        18,
                  );
                } else if (value == 'print_deal_form') {
                  bookingByIdProvider.reset();
                  await bookingByIdProvider.fetchBookingsById(
                    context,
                    widget.booking.id ?? "",
                  );

                  // Add a small delay to ensure state is updated
                  await Future.delayed(const Duration(milliseconds: 100));
                  DealFormPdf.generatePdf(
                    bookingByIdProvider.bookings,
                    declarationProvider.declarationModel,
                    modelHeadersProvider
                            .modelHeaders
                            ?.data
                            ?.model
                            .prices[0]
                            .metadata
                            ?.gstRate ??
                        18,
                  );
                } else if (value == 'print_delivery_challan') {
                  bookingByIdProvider.reset();
                  await bookingByIdProvider.fetchBookingsById(
                    context,
                    widget.booking.id ?? "",
                  );

                  await Future.delayed(const Duration(milliseconds: 100));

                  DelivaryChallanPdf.generatePdf(
                    bookingByIdProvider.bookings,
                    declarationProvider.declarationModel,
                    "delivery_challan",
                  );
                } else if (value == 'print_helmet_invoice') {
                  HelmetInvoiceForm.generateHelmetDeclarationPdf(
                    bookingByIdProvider.bookings,
                  );
                } else if (value == 'print_helmet_declaration') {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) =>
                        Center(child: CircularProgressIndicator()),
                  );

                  try {
                    await helmetDeclaratProvider.getHelmetDeclarations(
                      context,
                      bookingByIdProvider.bookings?.data.chassisNumber ?? "",
                    );

                    Navigator.pop(context);

                    if (helmetDeclaratProvider.helmetDeclarationPdf != null) {
                      final chassisNumber =
                          bookingByIdProvider.bookings?.data.chassisNumber ??
                          "helmet_declaration";
                      await _saveAndOpenPdf(
                        helmetDeclaratProvider.helmetDeclarationPdf!,
                        'helmet_declaration_$chassisNumber.pdf',
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('No helmet declaration found'),
                        ),
                      );
                    }
                  } catch (e) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Failed to get helmet declaration'),
                      ),
                    );
                  }
                } else if (value == 'finance_letter') {
                  _handleFinanceLetterAction(context, userDetailsProvider);
                } else if (value == 'kyc') {
                  _handleKycAction(context, userDetailsProvider);
                } else if (value == 'Add Downpayment') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddDownpaymentPage(booking: widget.booking),
                    ),
                  );
                }
              },
              itemBuilder: (BuildContext context) {
                List<PopupMenuItem<String>> menuItems = [
                  if (userDetailsProvider.userDetails?.data?.roles.any(
                        (role) => role.name == "MANAGER",
                      ) ??
                      true)
                    PopupMenuItem<String>(
                      value: "allocate_update",
                      child: Row(
                        children: [
                          Icon(Icons.directions_car, size: 20),
                          SizedBox(width: 8),
                          Text(
                            widget.booking.status != "ALLOCATED"
                                ? "Allocate Chassis"
                                : "Update Chassis",
                          ),
                        ],
                      ),
                    ),
                ];

                if (_isFinanceLetterEnabled()) {
                  menuItems.add(
                    PopupMenuItem<String>(
                      value: "finance_letter",
                      child: Row(
                        children: [
                          Icon(Icons.description, size: 20),
                          SizedBox(width: 8),
                          Text(_getFinanceLetterLabel()),
                        ],
                      ),
                    ),
                  );
                }
                if (widget.booking.documentStatus.financeLetter.status !=
                    "APPROVED") {
                  if (widget.booking.payment.type == "FINANCE") {
                    if (userDetailsProvider.userDetails?.data?.roles.any(
                          (role) => role.name == "MANAGER",
                        ) ??
                        true) {
                      menuItems.add(
                        PopupMenuItem<String>(
                          value: _isDownPaymentEnabled()
                              ? "Add Downpayment"
                              : null,
                          enabled: _isDownPaymentEnabled(),
                          child: Row(
                            children: [
                              Icon(Icons.payment, size: 20),
                              SizedBox(width: 8),
                              Text(_getDownPaymentLabel()),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                }
                if (widget.booking.documentStatus.kyc.status != "APPROVED") {
                  if (_isKycEnabled()) {
                    menuItems.add(
                      PopupMenuItem<String>(
                        value: "kyc",
                        child: Row(
                          children: [
                            Icon(Icons.verified_user, size: 20),
                            SizedBox(width: 8),
                            Text(_getKycLabel()),
                          ],
                        ),
                      ),
                    );
                  }
                }

                if (widget.booking.status == "ALLOCATED") {
                  final hasManagerRole = userDetailsProvider
                      .userDetails
                      ?.data
                      ?.roles
                      .any((role) => role.name == "MANAGER");
                  if (hasManagerRole ?? true) {
                    menuItems.add(
                      PopupMenuItem<String>(
                        value: "print_gst_invoice",
                        child: Row(
                          children: [
                            Icon(Icons.print, size: 20),
                            SizedBox(width: 8),
                            Text("Print Gst Invoice"),
                          ],
                        ),
                      ),
                    );
                  }
                }

                if (widget.booking.status == "ALLOCATED") {
                  final hasManagerRole = userDetailsProvider
                      .userDetails
                      ?.data
                      ?.roles
                      .any((role) => role.name == "MANAGER");
                  if (hasManagerRole ?? true) {
                    menuItems.add(
                      PopupMenuItem<String>(
                        value: "print_deal_form",
                        child: Row(
                          children: [
                            Icon(Icons.print, size: 20),
                            SizedBox(width: 8),
                            Text("Print Deal Form"),
                          ],
                        ),
                      ),
                    );
                  }
                }

                if (widget.booking.status == "ALLOCATED") {
                  final hasManagerRole = userDetailsProvider
                      .userDetails
                      ?.data
                      ?.roles
                      .any((role) => role.name == "MANAGER");
                  if (hasManagerRole ?? true) {
                    menuItems.add(
                      PopupMenuItem<String>(
                        value: "print_delivery_challan",
                        child: Row(
                          children: [
                            Icon(Icons.print, size: 20),
                            SizedBox(width: 8),
                            Text("Print Delivery Challan"),
                          ],
                        ),
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
