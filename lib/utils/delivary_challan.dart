import 'package:gandhi_tvs/models/declaration_model.dart' hide Data;
import 'package:gandhi_tvs/models/get_booking_by_id.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

class DelivaryChallanPdf {
  static Future<void> generatePdf(
    GetBookingsByIdModel? data,
    DeclarationModel? declaration,
    String copyType,
  ) async {
    final pdf = pw.Document();
    final bookingData = data?.data;
    if (bookingData == null) {
      throw Exception("No booking data available");
    }

    final ByteData logoData = await rootBundle.load('assets/images/logo.png');
    final Uint8List logoBytes = logoData.buffer.asUint8List();
    final tvsLogo = pw.MemoryImage(logoBytes);

    final totalAmount = bookingData.totalAmount?.toDouble() ?? 0.0;
    final discountedAmount =
        bookingData.discountedAmount?.toDouble() ?? totalAmount;

    final currentDate = DateTime.now();
    final formattedDate =
        "${currentDate.day.toString().padLeft(2, '0')}/${currentDate.month.toString().padLeft(2, '0')}/${currentDate.year}";

    // Determine display name and address based on booking type
    // final displayName = bookingData.bookingType == 'SUBDEALER'
    //     ? (bookingData.?.name ?? 'N/A')
    //     : (bookingData.customerDetails?.name ??
    //           bookingData.customerDetails?.fullName ??
    //           'N/A');

    // final displayAddress = bookingData.bookingType == 'SUBDEALER'

    //     ?? _getCustomerAddress(bookingData);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header with logo and title
              pw.Row(
                children: [
                  pw.Image(tvsLogo, width: 60, height: 60),
                  pw.Expanded(
                    child: pw.Center(
                      child: pw.Text(
                        "Sale / Delivery challan",
                        style: pw.TextStyle(
                          fontSize: 21,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 10),

              // Main information table
              pw.Table(
                columnWidths: {
                  0: const pw.FixedColumnWidth(80),
                  1: const pw.FixedColumnWidth(20),
                  2: const pw.FixedColumnWidth(200),
                  3: const pw.FixedColumnWidth(80),
                  4: const pw.FixedColumnWidth(200),
                },
                children: [
                  _buildTableRowWithBorders(
                    cells: [
                      pw.Text("Booking No.:"),
                      pw.Text(":"),
                      pw.Text(
                        bookingData.bookingNumber ?? 'N/A',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey600,
                        ),
                      ),
                      pw.Text("Sales Date"),
                      pw.Text(
                        formattedDate,
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey600,
                        ),
                      ),
                    ],
                    hasTopBorder: true,
                    hasBottomBorder: true,
                  ),
                  _buildTableRow(
                    cells: [
                      pw.Text('Name'),
                      pw.Text(":"),
                      pw.Text(
                        bookingData.customerDetails.name ?? "",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey600,
                        ),
                      ),
                      pw.SizedBox(),
                      pw.SizedBox(),
                    ],
                  ),
                  _buildTableRow(
                    cells: [
                      pw.Text('Address'),
                      pw.Text(":"),
                      pw.Text(
                        bookingData.customerDetails.address ?? "",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey600,
                        ),
                      ),
                      pw.SizedBox(),
                      pw.SizedBox(),
                    ],
                  ),
                  _buildTableRow(
                    cells: [
                      pw.Text("S.E Name"),
                      pw.Text(":"),
                      pw.Text(
                        bookingData.salesExecutive.name ?? 'N/A',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey600,
                        ),
                      ),
                      pw.SizedBox(),
                      pw.SizedBox(),
                    ],
                  ),
                  _buildTableRow(
                    cells: [
                      pw.Text("Model"),
                      pw.Text(":"),
                      pw.Text(
                        bookingData.model.modelName ??
                            bookingData.model.name ??
                            'N/A',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey600,
                        ),
                      ),
                      pw.Text("Colour :"),
                      pw.Text(
                        bookingData.color.name ?? 'N/A',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey600,
                        ),
                      ),
                    ],
                  ),
                  _buildTableRow(
                    cells: [
                      pw.Text("Chassis No"),
                      pw.Text(":"),
                      pw.Text(
                        bookingData.chassisNumber ?? '',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey600,
                        ),
                      ),
                      pw.Text("Key No. :"),
                      pw.Text(
                        bookingData.keyNumber?.toString() ?? '0',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey600,
                        ),
                      ),
                    ],
                  ),
                  _buildTableRow(
                    cells: [
                      pw.Text("Engine No"),
                      pw.Text(":"),
                      pw.Text(
                        bookingData.engineNumber ?? '',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey600,
                        ),
                      ),
                      pw.SizedBox(),
                      pw.SizedBox(),
                    ],
                  ),
                  _buildTableRow(
                    cells: [
                      pw.Text("Financer"),
                      pw.Text(":"),
                      pw.Text(
                        bookingData.payment.financer?.name ?? '',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey600,
                        ),
                      ),
                      pw.SizedBox(),
                      pw.SizedBox(),
                    ],
                  ),
                  _buildTableRow(
                    cells: [
                      pw.Text("Total"),
                      pw.Text(":"),
                      pw.Text(
                        "Rs.${discountedAmount.toStringAsFixed(0)}",
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey600,
                        ),
                      ),
                      // pw.Text("Grand Total :"),
                      // pw.Text(
                      //   "Rs.${discountedAmount.toStringAsFixed(0)}",
                      //   style: pw.TextStyle(
                      //     fontWeight: pw.FontWeight.bold,
                      //     color: PdfColors.grey600,
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 10),

              // Accessories section
              pw.Text(
                "ACC.DETAILS:",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.grey600,
                ),
              ),
              pw.Text(
                _getAccessoriesInfo(bookingData),
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.grey600,
                ),
              ),
              pw.SizedBox(height: 10),

              // Authorized signature box
              pw.Container(
                decoration: pw.BoxDecoration(
                  border: pw.Border(
                    top: pw.BorderSide(width: 2, color: PdfColors.grey400),
                    bottom: pw.BorderSide(width: 2, color: PdfColors.grey400),
                  ),
                ),
                padding: const pw.EdgeInsets.symmetric(vertical: 4),
                child: pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    "Authorised Signature",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.grey600,
                    ),
                  ),
                ),
              ),
              pw.SizedBox(height: 20),

              // Customer declarations
              pw.Text(
                "Customer Declarations:",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.grey600,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                _getDeclarationsText(declaration),
                textAlign: pw.TextAlign.justify,
                style: pw.TextStyle(fontSize: 11, color: PdfColors.grey600),
              ),
              pw.SizedBox(height: 20),

              // Customer signature
              pw.Text(
                "Customer Signature",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  color: PdfColors.grey600,
                ),
              ),
              pw.SizedBox(height: 20),

              // Jurisdiction
              pw.Center(
                child: pw.Text(
                  "Subject To Sangamner Jurisdiction",
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey600,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    // Add office copy for Customer Copy and Office Copy types
    if (copyType != 'Helmet') {
      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.all(20),
          build: (context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header with logo and title
                pw.Row(
                  children: [
                    pw.Image(tvsLogo, width: 60, height: 60),
                    pw.Expanded(
                      child: pw.Center(
                        child: pw.Text(
                          "Sale / Delivery challan",
                          style: pw.TextStyle(
                            fontSize: 21,
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),

                // Main information table
                pw.Table(
                  columnWidths: {
                    0: const pw.FixedColumnWidth(80),
                    1: const pw.FixedColumnWidth(20),
                    2: const pw.FixedColumnWidth(200),
                    3: const pw.FixedColumnWidth(80),
                    4: const pw.FixedColumnWidth(200),
                  },
                  children: [
                    _buildTableRowWithBorders(
                      cells: [
                        pw.Text("Booking No.:"),
                        pw.Text(":"),
                        pw.Text(
                          bookingData.bookingNumber ?? 'N/A',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.Text("Sales Date"),
                        pw.Text(
                          formattedDate,
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey600,
                          ),
                        ),
                      ],
                      hasTopBorder: true,
                      hasBottomBorder: true,
                    ),
                    _buildTableRow(
                      cells: [
                        pw.Text(
                          bookingData.bookingType == 'SUBDEALER'
                              ? 'Subdealer Name'
                              : 'Name',
                        ),
                        pw.Text(":"),
                        pw.Text(
                          bookingData.customerDetails.name ?? "",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.SizedBox(),
                        pw.SizedBox(),
                      ],
                    ),
                    _buildTableRow(
                      cells: [
                        pw.Text(
                          bookingData.bookingType == 'SUBDEALER'
                              ? 'Subdealer Address'
                              : 'Address',
                        ),
                        pw.Text(":"),
                        pw.Text(
                          bookingData.customerDetails.address ?? "",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.SizedBox(),
                        pw.SizedBox(),
                      ],
                    ),
                    _buildTableRow(
                      cells: [
                        pw.Text("S.E Name"),
                        pw.Text(":"),
                        pw.Text(
                          bookingData.salesExecutive.name ?? 'N/A',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.SizedBox(),
                        pw.SizedBox(),
                      ],
                    ),
                    _buildTableRow(
                      cells: [
                        pw.Text("Model"),
                        pw.Text(":"),
                        pw.Text(
                          bookingData.model.modelName ??
                              bookingData.model.name ??
                              'N/A',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.Text("Colour :"),
                        pw.Text(
                          bookingData.color.name ?? 'N/A',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey600,
                          ),
                        ),
                      ],
                    ),
                    _buildTableRow(
                      cells: [
                        pw.Text("Chassis No"),
                        pw.Text(":"),
                        pw.Text(
                          bookingData.chassisNumber ?? '',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.Text("Key No. :"),
                        pw.Text(
                          bookingData.keyNumber?.toString() ?? '0',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey600,
                          ),
                        ),
                      ],
                    ),
                    _buildTableRow(
                      cells: [
                        pw.Text("Engine No"),
                        pw.Text(":"),
                        pw.Text(
                          bookingData.engineNumber ?? '',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.SizedBox(),
                        pw.SizedBox(),
                      ],
                    ),
                    _buildTableRow(
                      cells: [
                        pw.Text("Financer"),
                        pw.Text(":"),
                        pw.Text(
                          bookingData.payment.financer?.name ?? '',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey600,
                          ),
                        ),
                        pw.SizedBox(),
                        pw.SizedBox(),
                      ],
                    ),
                    _buildTableRow(
                      cells: [
                        pw.Text("Total"),
                        pw.Text(":"),
                        pw.Text(
                          "Rs.${discountedAmount.toStringAsFixed(0)}",
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            color: PdfColors.grey600,
                          ),
                        ),
                        // pw.Text("Grand Total :"),
                        // pw.Text(
                        //   "Rs.${discountedAmount.toStringAsFixed(0)}",
                        //   style: pw.TextStyle(
                        //     fontWeight: pw.FontWeight.bold,
                        //     color: PdfColors.grey600,
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
                pw.SizedBox(height: 10),

                // Accessories section
                pw.Text(
                  "ACC.DETAILS:",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey600,
                  ),
                ),
                pw.Text(
                  _getAccessoriesInfo(bookingData),
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey600,
                  ),
                ),
                pw.SizedBox(height: 10),

                // Authorized signature box
                pw.Container(
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      top: pw.BorderSide(width: 2, color: PdfColors.grey400),
                      bottom: pw.BorderSide(width: 2, color: PdfColors.grey400),
                    ),
                  ),
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Align(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Text(
                      "Authorised Signature",
                      style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.grey600,
                      ),
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),

                // Customer declarations
                pw.Text(
                  "Customer Declarations:",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey600,
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  _getDeclarationsText(declaration),
                  textAlign: pw.TextAlign.justify,
                  style: pw.TextStyle(fontSize: 11, color: PdfColors.grey600),
                ),
                pw.SizedBox(height: 20),

                // Customer signature
                pw.Text(
                  "Customer Signature",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.grey600,
                  ),
                ),
                pw.SizedBox(height: 20),

                // Jurisdiction
                pw.Center(
                  child: pw.Text(
                    "Subject To Sangamner Jurisdiction",
                    style: pw.TextStyle(
                      fontSize: 14,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.grey600,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  // Helper method to build table rows with borders
  static pw.TableRow _buildTableRowWithBorders({
    required List<pw.Widget> cells,
    bool hasTopBorder = false,
    bool hasBottomBorder = false,
  }) {
    return pw.TableRow(
      decoration: pw.BoxDecoration(
        border: pw.Border(
          top: hasTopBorder
              ? pw.BorderSide(width: 2, color: PdfColors.grey400)
              : pw.BorderSide.none,
          bottom: hasBottomBorder
              ? pw.BorderSide(width: 2, color: PdfColors.grey400)
              : pw.BorderSide.none,
        ),
      ),
      children: cells,
    );
  }

  // Helper method to build regular table rows
  static pw.TableRow _buildTableRow({required List<pw.Widget> cells}) {
    return pw.TableRow(children: cells);
  }

  // Helper methods (unchanged from original)

  static String _getAccessoriesInfo(Data bookingData) {
    if (bookingData.accessories.isEmpty) return "NONE";

    return bookingData.accessories
        .map((a) => a.accessory?.name ?? "")
        .where((name) => name.isNotEmpty)
        .join(", ");
  }

  static String _getDeclarationsText(DeclarationModel? declaration) {
    if (declaration?.data.declarations.isNotEmpty == true) {
      return declaration!.data.declarations.map((d) => d.content).join(" ");
    }

    // Default declaration text
    return "I/We Authorized the dealer or its representative to register the vehicle at RTO In my/Our name as booked by us, However getting the vehicle insured from Insurance company & getting the vehicle registered from RTO is entirely my/our sole responsibility. Registration Number allotted by RTO will be acceptable to me else I will pre book for choice number at RTO at my own. Dealership has no role in RTO Number allocation I/We am/are exclusively responsible for any loss/penalty/legal action- occurred due to non-compliance of /Delay in Insurance or RTO registration. I have understood and accepted all I & C about warranty as per the Warranty policy of TVS MOTOR COMPANY Ltd & agree to abide the same. I have also understood & accepted that the warranty for Tyres & Battery Lies with concerned Manufacturer or its dealer & I will not claim for warranty of these products to TVS MOTOR COMPANY or to Its Dealer I am being informed about the price breakup, I had understood & agreed upon the same & then had booked the vehicle, I am bound to pay penal interest @ 24% P.A. on delayed payment. I accept that vehicle once sold by dealer shall not be taken back /replaced for any reason.";
  }

  // New method for generating helmet declaration
  static Future<void> generateHelmetDeclarationPdf(
    GetBookingsByIdModel? data,
  ) async {
    final pdf = pw.Document();
    final bookingData = data?.data;

    if (bookingData == null) {
      throw Exception("No booking data available");
    }

    final currentDate = DateTime.now();
    final formattedDate =
        "${currentDate.day.toString().padLeft(2, '0')}/${currentDate.month.toString().padLeft(2, '0')}/${currentDate.year}";

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Header
              pw.Center(
                child: pw.Text(
                  "हेल्मेट प्राप्ती घोषणापत्र",
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.SizedBox(height: 10),

              // Content
              pw.Center(
                child: pw.Text(
                  "केंद्रीय मोटर वाहन नियम १३८ { ४ } { फ }",
                  style: pw.TextStyle(fontSize: 12),
                ),
              ),
              pw.SizedBox(height: 10),

              // Divider
              pw.Divider(thickness: 2, color: PdfColors.grey400),
              pw.SizedBox(height: 20),

              // Declaration text
              pw.Text(
                "मी..${bookingData.customerDetails.name ?? 'N/A'}, असे घोषित करतो कि\n\n"
                "दि. $formattedDate रोजी गांधी मोटार टि व्हि यस नासिक\n"
                "या वितरकाकडून टि व्हि यस..${bookingData.model.modelName ?? bookingData.model.name ?? 'N/A'}, हे वाहन खरेदी केले आहे.\n"
                "त्याचा तपशील खालील प्रमाणे...",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 20),

              // Vehicle details
              pw.Text("चेसिस नंबर: ${bookingData.chassisNumber ?? ''}"),
              pw.Text("इंजिन नंबर: ${bookingData.engineNumber ?? ''}"),
              pw.SizedBox(height: 20),

              // More declaration text
              pw.Text(
                "केंद्रीय मोटर वाहन नियम १३८ { ४ } { फ } प्रमाणे वितरकाने दुचाकी वितरीत करते वेळी विहित "
                "मानाकनाचे २ (दोन) हेल्मेट पुरवणे/विकत देणे बंधनकारक आहे. त्याचप्रमाणे मला BUREAU OF INDIA STANDARS "
                "UNDER THE BUREAU OF INDIA ACT-1986 { 63 TO 1986 } या प्रमाणे हेल्मेट मिळाले आहे.\n\n"
                "मी याद्वारे जाहीर करतो/करते की वर दिलेला तपशील माझ्या संपूर्ण माहिती प्रमाणे व तपासा्रमाणे सत्य आहे.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 40),

              // Signatures
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("स्वाक्षरी व शिक्का"),
                      pw.Text("गांधी मोटर्स"),
                      pw.Text("नासिक"),
                    ],
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text("दुचाकी खरेदिदाराची स्वाक्षरी"),
                      pw.Text(
                        "नाव :- ${bookingData.customerDetails.name ?? 'N/A'}",
                      ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 40),

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
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
