// ignore_for_file: avoid_print, use_build_context_synchronously, deprecated_member_use

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/quotation_model.dart';
import 'package:provider/provider.dart';

Future<QuotationResponse?> getQuotationData(
  BuildContext context,
  String? quotationId,
) async {
  final provider = Provider.of<QuotationProvider>(context, listen: false);
  await provider.fetchQuotationById(quotationId, context);

  if (provider.errorMessage != null) {
    _showSnackBar(context, 'Error: ${provider.errorMessage}');
    return null;
  }

  final data = provider.quotation;
  if (data == null) {
    _showSnackBar(context, 'Quotation or PDF URL not found');
    return null;
  }

  return data;
}

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

Future<Uint8List?> fetchPdfBytes(
  BuildContext context,
  String? quotationId,
) async {
  try {
    final data = await getQuotationData(context, quotationId);
    if (data == null) return null;

    final dio = Dio();
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/temp_quotation.pdf';

    await dio.download(
      '$baseImageUrl/public${data.data.pdfUrl}',
      filePath,
      options: Options(
        receiveTimeout: const Duration(seconds: 30),
        validateStatus: (status) => status! < 500,
      ),
    );

    return File(filePath).readAsBytes();
  } catch (e) {
    print('Error fetching PDF: $e');
    _showSnackBar(context, 'Failed to fetch PDF: ${e.toString()}');
    return null;
  }
}

Future<String?> getPdfFilePath(
  BuildContext context,
  String? quotationId,
) async {
  final pdfBytes = await fetchPdfBytes(context, quotationId);
  if (pdfBytes == null) return null;

  final data = Provider.of<QuotationProvider>(
    context,
    listen: false,
  ).quotation?.data;

  try {
    final tempDir = await getTemporaryDirectory();
    final fileName =
        '${data?.customerDetails.name ?? DateTime.now().millisecondsSinceEpoch}_Quotation.pdf';
    final filePath = '${tempDir.path}/$fileName';

    await File(filePath).writeAsBytes(pdfBytes);
    return filePath;
  } catch (e) {
    print('Error writing PDF: $e');
    _showSnackBar(context, 'Failed to save PDF: ${e.toString()}');
    return null;
  }
}

Future<void> viewPdf(BuildContext context, String? quotationId) async {
  final filePath = await getPdfFilePath(context, quotationId);
  if (filePath == null) return;

  try {
    await OpenFile.open(filePath);
  } catch (e) {
    print('Error viewing PDF: $e');
    _showSnackBar(context, 'Failed to open PDF: ${e.toString()}');
  }
}

Future<void> printPdf(BuildContext context, String? quotationId) async {
  final pdfBytes = await fetchPdfBytes(context, quotationId);
  if (pdfBytes == null) return;

  try {
    await Printing.layoutPdf(onLayout: (_) => pdfBytes);
  } catch (e) {
    print('Error printing PDF: $e');
    _showSnackBar(context, 'Failed to print PDF: ${e.toString()}');
  }
}

Future<void> downloadPdf(BuildContext context, String? quotationId) async {
  final pdfBytes = await fetchPdfBytes(context, quotationId);
  if (pdfBytes == null) return;

  try {
    if (Platform.isAndroid) {
      final permission = await Permission.manageExternalStorage.request();
      if (!permission.isGranted) {
        _showSnackBar(context, 'Storage permission denied');
        return;
      }
    }

    final data = Provider.of<QuotationProvider>(
      context,
      listen: false,
    ).quotation?.data;

    final downloadsDir = Platform.isAndroid
        ? Directory('/storage/emulated/0/Download')
        : await getApplicationDocumentsDirectory();

    if (!await downloadsDir.exists()) {
      await downloadsDir.create(recursive: true);
    }

    final fileName =
        '${data?.customerDetails.name ?? DateTime.now().millisecondsSinceEpoch}_Quotation.pdf';
    final filePath = '${downloadsDir.path}/$fileName';
    final file = File(filePath);

    await file.writeAsBytes(pdfBytes);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('PDF downloaded successfully'),
        action: SnackBarAction(
          label: 'Open',
          onPressed: () => OpenFile.open(filePath),
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  } catch (e) {
    print('Error downloading PDF: $e');
    _showSnackBar(context, 'Failed to download PDF: ${e.toString()}');
  }
}

Future<void> sharePdf(BuildContext context, String? quotationId) async {
  final filePath = await getPdfFilePath(context, quotationId);
  if (filePath == null) return;

  await Share.shareXFiles([XFile(filePath)], subject: 'Quotation $quotationId');
}

Future<void> sharePdfOnWhatsApp(
  BuildContext context,
  String? quotationId,
  String phoneNumber,
) async {
  try {
    final message =
        'Thank you for preferring Us.\nIt is our pleasure to serve customers like you.\nYour bike Quotation is attached.\n\nRegards,\nGandhi TVS Nashik';

    final uri = Uri.parse(
      "whatsapp://send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}",
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw Exception("WhatsApp not installed");
    }
  } catch (e) {
    print('Error sharing on WhatsApp: $e');
    _showSnackBar(context, 'Failed to share via WhatsApp: ${e.toString()}');
  }
}
