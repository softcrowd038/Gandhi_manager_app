import 'package:gandhi_tvs/models/get_booking_by_id.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:intl/intl.dart';

class HelmetInvoiceForm {
  static Future<void> generateHelmetDeclarationPdf(
    GetBookingsByIdModel? data,
  ) async {
    final pdf = pw.Document();
    final bookingData = data?.data;

    if (bookingData == null) {
      throw Exception("No booking data available");
    }

    // Load TVS logo
    final ByteData logoData = await rootBundle.load('assets/images/logo.png');
    final Uint8List logoBytes = logoData.buffer.asUint8List();
    final tvsLogo = pw.MemoryImage(logoBytes);

    final currentDate = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);
    final invoiceDate = bookingData.createdAt != null
        ? DateFormat(
            'dd/MM/yyyy',
          ).format(DateTime.parse(bookingData.createdAt.toString()))
        : formattedDate;

    // Find helmet component
    if (bookingData.priceComponents.isNotEmpty) {
    } else {}

    final qty = 2;

    final hsnCode = '000000';

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header with logo and invoice details
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Image(tvsLogo, width: 60, height: 60),
                      pw.Text(
                        "Invoice No: ${bookingData.bookingNumber ?? 'BK000038'}",
                      ),
                      pw.Text("Invoice Date: $invoiceDate"),
                    ],
                  ),
                  pw.Text(
                    "TAX Invoice",
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Divider(thickness: 2, color: PdfColors.grey400),
              pw.SizedBox(height: 10),

              // Dealer and customer information
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Dealer info
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "GANDHI MOTORS",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text(
                          "'JOGPREET' ASHER ESTATE UPNAGAR, NASHIK ROAD, NASHIK 422101.",
                        ),
                        pw.Text("Phone:"),
                        pw.Text("GSTIN NO.-27AATC68896K1ZN"),
                      ],
                    ),
                  ),
                  pw.SizedBox(width: 20),

                  // Customer info
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          "${bookingData.customerDetails?.salutation ?? 'Mrs.'} ${bookingData.customerDetails?.name ?? 'N/A'}",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                        pw.Text("Address: ${_getCustomerAddress(bookingData)}"),
                        pw.Text(
                          "Mobile: ${bookingData.customerDetails?.mobile1 ?? 'N/A'}",
                        ),
                        pw.Text(
                          "Aadhar: ${bookingData.customerDetails?.aadharNumber ?? 'N/A'}",
                        ),
                        pw.Text(
                          "Bill Type: ${bookingData.payment?.type?.toUpperCase() ?? 'FINANCE'}",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              pw.Divider(thickness: 2, color: PdfColors.grey400),
              pw.SizedBox(height: 10),

              // Helmet table - Simplified to match PDF format
              pw.Table(
                border: pw.TableBorder(
                  verticalInside: pw.BorderSide.none,
                  horizontalInside: pw.BorderSide.none,
                  bottom: const pw.BorderSide(width: 1, color: PdfColors.grey),
                ),
                columnWidths: {
                  0: const pw.FlexColumnWidth(2),
                  1: const pw.FlexColumnWidth(1),
                  2: const pw.FlexColumnWidth(0.5),
                  3: const pw.FlexColumnWidth(1),
                  4: const pw.FlexColumnWidth(1),
                  5: const pw.FlexColumnWidth(0.8),
                  6: const pw.FlexColumnWidth(1),
                  7: const pw.FlexColumnWidth(0.8),
                  8: const pw.FlexColumnWidth(1),
                },
                children: [
                  // Header row
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(
                      border: pw.Border(
                        bottom: pw.BorderSide(width: 1, color: PdfColors.grey),
                      ),
                    ),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Particulars",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "HSN Code",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Qty",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Unit Cost",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Taxable",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "CGST%",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Amount",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "SGST%",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "Amount",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                    ],
                  ),

                  // Data row - All zeros as per PDF
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("TVS HELMET"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(hsnCode),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(qty.toString()),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("0.00"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("0.00"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("0.00%"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("0.00"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("0.00%"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("0.00"),
                      ),
                    ],
                  ),
                ],
              ),

              // Totals section - All zeros
              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 4,
                    child: pw.Text(
                      "Total",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      "0.00",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Expanded(flex: 1, child: pw.Text("")),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      "0.00",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Expanded(flex: 1, child: pw.Text("")),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      "0.00",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                ],
              ),

              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 8,
                    child: pw.Text(
                      "GRAND TOTAL",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      "0.00",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                ],
              ),

              pw.Row(
                children: [
                  pw.Expanded(flex: 8, child: pw.Text("ROUND OFF")),
                  pw.Expanded(flex: 1, child: pw.Text("+0.00")),
                ],
              ),

              pw.Row(
                children: [
                  pw.Expanded(
                    flex: 8,
                    child: pw.Text(
                      "NET TOTAL",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Text(
                      "Rs. 0",
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    ),
                  ),
                ],
              ),

              pw.SizedBox(height: 10),
              pw.Divider(thickness: 2, color: PdfColors.grey400),
              pw.SizedBox(height: 10),

              // Vehicle details table
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FlexColumnWidth(2),
                  1: const pw.FlexColumnWidth(3),
                  2: const pw.FlexColumnWidth(2),
                  3: const pw.FlexColumnWidth(3),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "PART DESCRIPTION",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "FRAME NO",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "ENGINE NO",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          "CWI BOOKLET NO",
                          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          bookingData.model?.modelName ??
                              bookingData.model?.name ??
                              'JUPITER 125 CC DISC SX OBD IIB',
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(
                          bookingData.chassisNumber ?? 'MH12ABCDE12745444',
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(bookingData.engineNumber ?? ''),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text(""),
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 10),

              // Message from dealer
              pw.Text(
                "Message from Dealer:- Certified that goods covered by this bill suffered tax at hands of supplier. Vehicle once sold shall not be taken back /replaced for any reason.",
                style: pw.TextStyle(fontSize: 10),
              ),
              pw.SizedBox(height: 10),
              pw.Divider(thickness: 2, color: PdfColors.grey400),
              pw.SizedBox(height: 10),

              // Signatures
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    "(${bookingData.customerDetails?.salutation ?? 'Mrs.'} ${bookingData.customerDetails?.name ?? 'BH crtm'})",
                  ),
                  pw.Text(
                    "For (GANDHI MOTORS)\nAuthorised Signatory",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                    textAlign: pw.TextAlign.right,
                  ),
                ],
              ),
              pw.SizedBox(height: 10),

              // Jurisdiction
              pw.Center(
                child: pw.Text(
                  "Subject To Nashik Jurisdiction",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Divider(thickness: 2, color: PdfColors.grey400),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  // Helper method to format customer address
  static String _getCustomerAddress(Data bookingData) {
    final customer = bookingData.customerDetails;
    if (customer == null) return "edfrdefde";

    List<String> addressParts = [];
    if (customer.address != null && customer.address!.isNotEmpty) {
      addressParts.add(customer.address!);
    }
    if (customer.taluka != null && customer.taluka!.isNotEmpty) {
      addressParts.add(customer.taluka!);
    }
    if (customer.district != null && customer.district!.isNotEmpty) {
      addressParts.add(customer.district!);
    }

    return addressParts.isNotEmpty ? addressParts.join(", ") : "edfrdefde";
  }
}
