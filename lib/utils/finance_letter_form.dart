import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/all_bookings_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';

void handlePrintFinanceLetter({
  required Booking bookingData,
  required double dealAmount,
  required double financeDisbursement,
  required double gcAmount,
  required double downPayment,
}) {
  final today = DateFormat('dd/MM/yyyy').format(DateTime.now());

  // Create PDF document
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(20),
      build: (pw.Context context) {
        return pw.Container(
          decoration: pw.BoxDecoration(color: PdfColors.white),
          padding: const pw.EdgeInsets.all(30),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Date
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: [
                  pw.Text('Date: ', style: pw.TextStyle(fontSize: 12)),
                  pw.Text(
                    today,
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),

              pw.SizedBox(height: 15),

              // Recipient address
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('To,', style: pw.TextStyle(fontSize: 12)),
                  pw.Text(
                    'The Director/Manager,',
                    style: pw.TextStyle(fontSize: 12),
                  ),
                  pw.Text(
                    'Gandhi Motors Pvt Ltd,',
                    style: pw.TextStyle(fontSize: 12),
                  ),
                  pw.Text('Nasik', style: pw.TextStyle(fontSize: 12)),
                ],
              ),

              pw.SizedBox(height: 15),

              // Subject
              pw.Text(
                'Sub:- Delivery Order & Disbursement Assurance letter.',
                style: pw.TextStyle(
                  fontSize: 12,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 15),

              // Salutation
              pw.Text('Dear sir,', style: pw.TextStyle(fontSize: 12)),

              pw.SizedBox(height: 15),

              // Introduction
              pw.Text(
                'We have sanctioned a loan for purchase of a two-wheeler to our below mentioned customer:',
                style: pw.TextStyle(fontSize: 12),
              ),

              pw.SizedBox(height: 15),

              // Customer name
              pw.Text(
                'Name : Mr./Mrs. : ${bookingData.customerDetails.name ?? ''}',
                style: pw.TextStyle(fontSize: 12),
              ),

              pw.SizedBox(height: 15),

              // Vehicle details
              pw.Row(
                children: [
                  pw.Text(
                    'Vehicle make & model : ',
                    style: pw.TextStyle(fontSize: 12),
                  ),
                  pw.Text(
                    bookingData.model.modelName ?? "",
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ],
              ),

              pw.SizedBox(height: 8),

              pw.Text(
                'Booking Number: ${bookingData.bookingNumber}',
                style: pw.TextStyle(fontSize: 12),
              ),

              pw.SizedBox(height: 15),

              // Details table
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FlexColumnWidth(2),
                  1: const pw.FlexColumnWidth(1),
                },
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          'Total Deal Amount including On road price + Accessories + Addons',
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          '$dealAmount Rs.',
                          style: pw.TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          'Disbursement Amount assured by finance company',
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          '$financeDisbursement Rs.',
                          style: pw.TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          'Finance Charges',
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          '$gcAmount Rs.',
                          style: pw.TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          'Net Down Payment to be taken from Customer',
                          style: pw.TextStyle(
                            fontSize: 12,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(6),
                        child: pw.Text(
                          '$downPayment Rs.',
                          style: pw.TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              pw.SizedBox(height: 15),

              // Instruction paragraphs
              pw.Text(
                'The loan process for the purchase of abovesaid vehicle has been completed and the Loan amount will be disbursed to your bank account within two working days from the date of issuance of this letter.',
                style: pw.TextStyle(fontSize: 12),
                textAlign: pw.TextAlign.justify,
              ),

              pw.SizedBox(height: 10),

              pw.Text(
                'This letter is non revokable & we promise to pay you the above-mentioned loan amount within stipulated time.',
                style: pw.TextStyle(fontSize: 12),
                textAlign: pw.TextAlign.justify,
              ),

              pw.SizedBox(height: 10),

              pw.Text(
                'You are hereby requested to endorse our hypothecation mark on the vehicle and deliver the same to the above-mentioned customer after registering the vehicle with the respective RTO Office & give us the details of RTO registration along with the invoice, insurance & Down payment receipt.',
                style: pw.TextStyle(fontSize: 12),
                textAlign: pw.TextAlign.justify,
              ),

              pw.SizedBox(height: 10),

              pw.Text(
                'Please do the needful.',
                style: pw.TextStyle(fontSize: 12),
                textAlign: pw.TextAlign.justify,
              ),

              pw.SizedBox(height: 25),

              // Signature block
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'For & on behalf of',
                    style: pw.TextStyle(fontSize: 12),
                  ),
                  pw.Text(
                    'Financer\'s / Bank',
                    style: pw.TextStyle(fontSize: 12),
                  ),
                  pw.Text(
                    'Name: ${bookingData.payment.financer?.name ?? ''}',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 15),
                  pw.Text(
                    'Employee Name:________________________________',
                    style: pw.TextStyle(fontSize: 12),
                  ),
                  pw.SizedBox(height: 10),
                  pw.Text(
                    'Mobile No:________________________________',
                    style: pw.TextStyle(fontSize: 12),
                  ),
                ],
              ),

              pw.SizedBox(height: 25),

              // Authorized signature
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Container(
                  width: 130,
                  decoration: pw.BoxDecoration(
                    border: pw.Border(
                      top: pw.BorderSide(
                        width: 1,
                        style: pw.BorderStyle.dashed,
                      ),
                    ),
                  ),
                  padding: const pw.EdgeInsets.only(top: 4),
                  child: pw.Text(
                    'Authorised Signature',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColors.grey600,
                    ),
                    textAlign: pw.TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    ),
  );

  // Print the document
  Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf.save());
}
