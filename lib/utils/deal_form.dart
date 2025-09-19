// ignore_for_file: deprecated_member_use

import 'package:gandhi_tvs/models/declaration_model.dart' hide Data;
import 'package:gandhi_tvs/models/get_booking_by_id.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class DealFormPdf {
  static Future<void> generatePdf(
    GetBookingsByIdModel? data,
    DeclarationModel? declaration,
    String? gstRateFetched,
  ) async {
    final pdf = pw.Document();
    final bookingData = data?.data;

    if (bookingData == null) {
      throw Exception("No booking data available");
    }

    final currentDate =
        "${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}";

    // Calculate GST components with proper GST rate detection
    final priceComponentsWithGST = bookingData.priceComponents.map((component) {
      final lineTotal = component.discountedValue?.toDouble() ?? 0.0;
      final headerKey = component.header?.headerKey ?? '';
      final gstRate = double.parse(gstRateFetched ?? "");
      final unitCost = component.originalValue?.toDouble() ?? 0.0;
      final taxableValue = lineTotal * 100 / (100 + gstRate);
      final totalGST = lineTotal - taxableValue;
      final cgstAmount = totalGST / 2;
      final sgstAmount = totalGST / 2;
      final discount =
          (component.discountedValue ?? 0) < (component.originalValue ?? 0)
          ? (component.originalValue ?? 0) - (component.discountedValue ?? 0)
          : 0;

      return {
        'component': component,
        'unitCost': unitCost,
        'taxableValue': taxableValue,
        'cgstAmount': cgstAmount,
        'sgstAmount': sgstAmount,
        'gstRate': gstRate,
        'discount': discount,
        'lineTotal': lineTotal,
        'hsnCode': _getHsnCodeForComponent(headerKey),
        'headerName': component.header?.headerKey ?? 'N/A',
      };
    }).toList();

    // Calculate totals
    final insuranceComponent = bookingData.priceComponents.firstWhere(
      (comp) =>
          (comp.header?.headerKey ?? '').toUpperCase().contains('INSURANCE'),
      orElse: () => PriceComponent(
        header: Header(id: '', headerKey: '', headerId: ''),
        originalValue: 0,
        discountedValue: 0,
        isDiscountable: false,
        isMandatory: false,
      ),
    );
    final insuranceCharges =
        insuranceComponent.originalValue?.toDouble() ?? 0.0;

    final rtoComponent = bookingData.priceComponents.firstWhere(
      (comp) => (comp.header?.headerKey ?? '').toUpperCase().contains('RTO'),
      orElse: () => PriceComponent(
        header: Header(id: '', headerKey: '', headerId: ''),
        originalValue: 0,
        discountedValue: 0,
        isDiscountable: false,
        isMandatory: false,
      ),
    );
    final rtoCharges = rtoComponent.originalValue?.toDouble() ?? 0.0;

    final hpCharges = bookingData.hypothecationCharges?.toDouble() ?? 0.0;
    final totalB = insuranceCharges + rtoCharges + hpCharges;
    final totalA = (bookingData.discountedAmount?.toDouble() ?? 0.0) - totalB;
    final grandTotal = totalA + totalB;
    final branchGstin = bookingData.branch?.id ?? bookingData.gstin ?? 'N/A';
    final branchName = bookingData.branch?.name ?? 'N/A';

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(20),
        build: (context) => [
          // ---------- Header ----------
          _buildHeader(bookingData, currentDate, branchGstin, branchName),
          pw.Divider(),

          // ---------- RTO Type ----------
          pw.Text(
            "RTO TYPE: ${bookingData.rto?.toUpperCase() ?? 'N/A'}",
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
          ),
          pw.Divider(),

          // ---------- Customer Info ----------
          _buildCustomerInfo(bookingData),
          pw.Divider(),

          // ---------- Purchase Details ----------
          _buildPurchaseDetails(bookingData),
          pw.SizedBox(height: 8),

          // ---------- Price Breakdown ----------
          _buildPriceTable(priceComponentsWithGST),
          pw.SizedBox(height: 8),

          // ---------- Totals ----------
          _buildTotalsSection(
            totalA,
            insuranceCharges,
            rtoCharges,
            hpCharges,
            totalB,
            grandTotal,
          ),
          pw.SizedBox(height: 10),

          // ---------- Broker Info ----------
          _buildBrokerInfo(bookingData),
          pw.SizedBox(height: 10),

          // ---------- Accessories ----------
          _buildAccessoriesInfo(bookingData),
          pw.Divider(),

          // ---------- Declarations ----------
          _buildDeclarationsSection(declaration),
          pw.SizedBox(height: 20),

          // ---------- Signatures ----------
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  // Helper methods for better code organization

  static pw.Widget _buildHeader(
    Data bookingData,
    String currentDate,
    String branchGstin,
    String branchName,
  ) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              "GANDHI MOTORS PVT LTD",
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
            pw.SizedBox(height: 4),
            pw.Text("Authorized Main Dealer: TVS Motor Company Ltd."),
            pw.Text(
              "Registered office: 'JOGPREET' Asher Estate, Near Ichhamani Lawns,",
            ),
            pw.Text("Upnagar, Nashik Road, Nashik, 7498993672"),
            pw.Text("GSTIN: $branchGstin"),
            pw.Text("Branch: $branchName"),
          ],
        ),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text("Date: $currentDate"),
            if (bookingData.bookingType == 'SUBDEALER') ...[
              pw.Text("Subdealer: ${bookingData.id ?? 'N/A'}"),
              pw.Text("Address: ${bookingData.branch?.address ?? 'N/A'}"),
            ],
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildCustomerInfo(Data bookingData) {
    final customer = bookingData.customerDetails;
    return pw.Row(
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("Invoice Number: ${bookingData.bookingNumber ?? 'N/A'}"),
              pw.Text(
                "Customer Name: ${customer?.name ?? customer?.fullName ?? 'N/A'}",
              ),
              pw.Text(
                "Address: ${customer?.address ?? 'N/A'}, ${customer?.taluka ?? 'N/A'}",
              ),
              pw.Text("Taluka: ${customer?.taluka ?? 'N/A'}"),
              pw.Text("Mobile: ${customer?.mobile1 ?? 'N/A'}"),
              pw.Text(
                "Exchange Mode: ${bookingData.exchange == true ? 'YES' : 'NO'}",
              ),
              pw.Text("Aadhar No.: ${customer?.aadharNumber ?? 'N/A'}"),
              pw.Text("HPA: ${bookingData.hpa == true ? 'YES' : 'NO'}"),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("GSTIN: ${bookingData.gstin ?? 'N/A'}"),
              pw.Text("District: ${customer?.district ?? 'N/A'}"),
              pw.Text("Pincode: ${customer?.pincode ?? 'N/A'}"),
              pw.Text("D.O.B: ${customer?.dob ?? 'N/A'}"),
              pw.Text("Payment Mode: ${bookingData.payment?.type ?? 'CASH'}"),
              pw.Text(
                "Financer: ${bookingData.payment?.financer?.name ?? 'N/A'}",
              ),
              pw.Text(
                "Sales Representative Name: ${bookingData.salesExecutive?.name ?? 'N/A'}",
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildPurchaseDetails(Data bookingData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "Purchase Details:",
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
        pw.Table(
          border: null,
          children: [
            pw.TableRow(
              children: [
                pw.Text(
                  "Model Name: ${bookingData.model?.modelName ?? bookingData.model?.name ?? 'N/A'}",
                ),
                pw.Text(
                  "Battery No: ${bookingData.batteryNumber?.toString() ?? 'N/A'}",
                ),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text("Chassis No: ${bookingData.chassisNumber ?? 'N/A'}"),
                pw.Text("Colour: ${bookingData.color?.name ?? 'N/A'}"),
              ],
            ),
            pw.TableRow(
              children: [
                pw.Text("Engine No: ${bookingData.engineNumber ?? 'N/A'}"),
                pw.Text("Key No: ${bookingData.keyNumber ?? 'N/A'}"),
              ],
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildPriceTable(
    List<Map<String, dynamic>> priceComponentsWithGST,
  ) {
    final filteredComponents = priceComponentsWithGST.where((item) {
      final headerName = item['headerName'].toString().toUpperCase();
      return !headerName.contains('INSURANCE') &&
          !headerName.contains('RTO') &&
          !headerName.contains('HPA') &&
          !headerName.contains('HYPOTHECATION');
    }).toList();

    return pw.Table(
      border: pw.TableBorder.all(),
      columnWidths: {
        0: const pw.FlexColumnWidth(2.5),
        1: const pw.FlexColumnWidth(0.8),
        2: const pw.FlexColumnWidth(1.0),
        3: const pw.FlexColumnWidth(1.0),
        4: const pw.FlexColumnWidth(0.7),
        5: const pw.FlexColumnWidth(1.0),
        6: const pw.FlexColumnWidth(0.7),
        7: const pw.FlexColumnWidth(1.0),
        8: const pw.FlexColumnWidth(1.0),
        9: const pw.FlexColumnWidth(1.0),
      },
      defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.white),
          children: [
            _buildTableCell(
              "Particulars",
              isHeader: true,
              maxLines: 3,
              textAlign: pw.TextAlign.left,
            ),
            _buildTableCell("HSN", isHeader: true, maxLines: 1),
            _buildTableCell("Unit Cost", isHeader: true, maxLines: 1),
            _buildTableCell("Taxable", isHeader: true, maxLines: 1),
            _buildTableCell("CGST", isHeader: true, maxLines: 1),
            _buildTableCell("CGST Amt", isHeader: true, maxLines: 1),
            _buildTableCell("SGST", isHeader: true, maxLines: 1),
            _buildTableCell("SGST Amt", isHeader: true, maxLines: 1),
            _buildTableCell("Discount", isHeader: true, maxLines: 1),
            _buildTableCell("Total", isHeader: true, maxLines: 1),
          ],
        ),

        ...filteredComponents.map((item) {
          return pw.TableRow(
            verticalAlignment: pw.TableCellVerticalAlignment.middle,
            children: [
              _buildTableCell(
                item['headerName'].toString(),
                maxLines: 3,
                textAlign: pw.TextAlign.left,
                fontSize: 10,
              ),
              _buildTableCell(item['hsnCode'].toString(), maxLines: 1),
              _buildTableCell(item['unitCost'].toStringAsFixed(2), maxLines: 1),
              _buildTableCell(
                item['taxableValue'].toStringAsFixed(2),
                maxLines: 1,
              ),
              _buildTableCell(
                "${(item['gstRate'] / 2).toStringAsFixed(2)}%",
                maxLines: 1,
              ),
              _buildTableCell(
                item['cgstAmount'].toStringAsFixed(2),
                maxLines: 1,
              ),
              _buildTableCell(
                "${(item['gstRate'] / 2).toStringAsFixed(2)}%",
                maxLines: 1,
              ),
              _buildTableCell(
                item['sgstAmount'].toStringAsFixed(2),
                maxLines: 1,
              ),
              _buildTableCell(item['discount'].toStringAsFixed(2), maxLines: 1),
              _buildTableCell(
                item['lineTotal'].toStringAsFixed(2),
                maxLines: 1,
              ),
            ],
          );
        }),
      ],
    );
  }

  static pw.Widget _buildTableCell(
    String text, {
    bool isHeader = false,
    int? maxLines,
    pw.TextAlign textAlign = pw.TextAlign.center,
    double? fontSize,
  }) {
    return pw.Container(
      padding: const pw.EdgeInsets.symmetric(horizontal: 2, vertical: 1),
      constraints: const pw.BoxConstraints(minHeight: 15),
      child: pw.Text(
        text,
        style: isHeader
            ? pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
                fontSize: fontSize ?? 10,
              )
            : pw.TextStyle(fontSize: fontSize ?? 10),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: maxLines != null ? pw.TextOverflow.visible : null,
      ),
    );
  }

  static pw.Widget _buildTotalsSection(
    double totalA,
    double insuranceCharges,
    double rtoCharges,
    double hpCharges,
    double totalB,
    double grandTotal,
  ) {
    return pw.Table(
      border: null,
      children: [
        pw.TableRow(
          children: [
            pw.Text("Total(A)"),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(totalA.toStringAsFixed(2)),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Text("INSURANCE CHARGES"),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(insuranceCharges.toStringAsFixed(2)),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Text("RTO TAX,REGISTRATION SMART CARD CHARGES AGENT FEES"),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(rtoCharges.toStringAsFixed(2)),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Text("HP CHARGES"),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(hpCharges.toStringAsFixed(2)),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Text("TOTAL(B)"),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(totalB.toStringAsFixed(2)),
            ),
          ],
        ),
        pw.TableRow(
          children: [
            pw.Text(
              "GRAND TOTAL(A) + (B)",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
            ),
            pw.Align(
              alignment: pw.Alignment.centerRight,
              child: pw.Text(
                grandTotal.toStringAsFixed(2),
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
            ),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildBrokerInfo(Data bookingData) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          "Ex. Broker/ Sub Dealer: ${bookingData.exchangeDetails?.broker?.name ?? 'N/A'}",
        ),
        pw.Text(
          "Ex. Veh No: ${bookingData.exchangeDetails?.vehicleNumber ?? 'N/A'}",
        ),
      ],
    );
  }

  static pw.Widget _buildAccessoriesInfo(Data bookingData) {
    final accessoryNames = bookingData.accessories
        .map((a) => a.accessory?.name)
        .where((n) => n != null && n.isNotEmpty)
        .join(', ');

    return pw.Text(
      "ACC.DETAILS: ${accessoryNames.isNotEmpty ? accessoryNames : 'NONE'}",
    );
  }

  static pw.Widget _buildDeclarationsSection(DeclarationModel? declaration) {
    final defaultDeclaration =
        "Declaration- I/We Authorize the Dealer to register the vehicle at RTO in my/our name .2) Getting the vehicle insured from insurance company is my entire responsibility & there will be no liability on dealer for any loss. 3) Getting the vehicle registered from RTO is solely my responsibility & exclusively I/we shall/will be responsible for any loss/penalty/legal charge from RTO/Police for not getting the vehicle registered or for delayed registration. 4) Registration Number allotted by RTO will be acceptable to me else I will pre book for choice number at RTO at my own. Dealership has no role in RTO Number allocation 5) I had been informed & understood the T&C about warranty policy as laid by TVS MOTOR CO. LTD & I agree to abide the same 6) I/We agree that the price at the time of delivery will be applicable. 7) I am being informed about the price breakup, I had understood & agreed upon the same & then had booked the vehicle 8)I am bound to pay an interest @24% p.a. as penalty if payment is delayed for more than 5 days from the date of booking. 9) Subject to sanguimer Jurisdication. I accept that vehicle once sold by dealer shall not be taken back /replaced for any reason.";

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "DECLARATIONS:",
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
        ),
        pw.Text(
          declaration?.data.declarations.isNotEmpty == true
              ? declaration!.data.declarations
                    .map((d) => "${d.priority}) ${d.content}")
                    .join('. ')
              : defaultDeclaration,
        ),
      ],
    );
  }

  // Utility methods
  // static double _getGstRateForComponent(String headerKey) {
  //   final headerUpper = headerKey.toUpperCase();
  //   if (headerUpper.contains('INSURANCE') || headerUpper.contains('RTO')) {
  //     return 0.0;
  //   }
  //   return headerUpper.; // Default GST rate
  // }

  static String _getHsnCodeForComponent(String headerKey) {
    final headerUpper = headerKey.toUpperCase();
    if (headerUpper.contains('VEHICLE')) return '8703';
    if (headerUpper.contains('INSURANCE')) return '9971';
    if (headerUpper.contains('RTO')) return '9997';
    if (headerUpper.contains('ACCESSORY')) return '8708';
    return 'N/A';
  }
}
