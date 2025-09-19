import 'package:gandhi_tvs/models/get_booking_by_id.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class HelmetDeclarationForm {
  static Future<void> generateHelmetDeclarationPdf(
    GetBookingsByIdModel? data,
  ) async {
    final pdf = pw.Document();
    final bookingData = data?.data;

    if (bookingData == null) {
      throw Exception("No booking data available");
    }

    final currentDate = DateTime.now();
    final formattedDate = DateFormat('dd/MM/yyyy').format(currentDate);

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
                "मी..${bookingData.customerDetails?.name ?? 'N/A'}, असे घोषित करतो कि\n\n"
                "दि. $formattedDate रोजी गांधी मोटार टि व्हि यस नासिक\n"
                "या वितरकाकडून टि व्हि यस..${bookingData.model?.modelName ?? bookingData.model?.name ?? 'N/A'}, हे वाहन खरेदी केले आहे.\n"
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
                        "नाव :- ${bookingData.customerDetails?.name ?? 'N/A'}",
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
