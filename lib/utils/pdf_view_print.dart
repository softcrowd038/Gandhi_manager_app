// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:http/http.dart' as http;

Future<void> viewHtmlAsPdf(BuildContext context, String htmlUrl) async {
  try {
    final htmlContent = await fetchHtmlContent(htmlUrl);
    if (htmlContent == null) {
      showSnackBar(context, 'Failed to fetch HTML for viewing');
      return;
    }

    final pdfFile = await convertHtmlToPdf(htmlContent, 'viewed_file');
    if (pdfFile == null) {
      showSnackBar(context, 'Failed to convert HTML to PDF');
      return;
    }

    await OpenFile.open(pdfFile.path);
  } catch (e) {
    showSnackBar(context, 'Failed to view PDF: $e');
  }
}

Future<void> printHtmlAsPdf(BuildContext context, String htmlUrl) async {
  try {
    final htmlContent = await fetchHtmlContent(htmlUrl);
    if (htmlContent == null) {
      showSnackBar(context, 'Failed to fetch HTML for printing');
      return;
    }

    final pdfFile = await convertHtmlToPdf(htmlContent, 'printed_file');
    if (pdfFile == null) {
      showSnackBar(context, 'Failed to convert HTML to PDF');
      return;
    }

    final pdfBytes = await pdfFile.readAsBytes();
    await Printing.layoutPdf(onLayout: (_) => pdfBytes);
  } catch (e) {
    showSnackBar(context, 'Failed to print PDF: $e');
  }
}

Future<void> downloadHtmlAsPdf(
  BuildContext context,
  String htmlUrl,
  String fileName,
) async {
  try {
    final htmlContent = await fetchHtmlContent(htmlUrl);
    if (htmlContent == null) {
      showSnackBar(context, 'Failed to fetch HTML for download');
      return;
    }

    final pdfFile = await convertHtmlToPdf(htmlContent, fileName);
    if (pdfFile == null) {
      showSnackBar(context, 'Failed to convert HTML to PDF');
      return;
    }

    if (Platform.isAndroid) {
      PermissionStatus status;

      if (await Permission.manageExternalStorage.isGranted) {
        status = PermissionStatus.granted;
      } else {
        status = await Permission.manageExternalStorage.request();
      }

      if (!status.isGranted) {
        if (status.isPermanentlyDenied) {
          openAppSettings();
        }
        showSnackBar(context, 'Storage permission denied');
        return;
      }
    }

    final downloadsDir = Platform.isAndroid
        ? Directory('/storage/emulated/0/Download')
        : await getApplicationDocumentsDirectory();

    if (!await downloadsDir.exists()) {
      await downloadsDir.create(recursive: true);
    }

    final savedFilePath = '${downloadsDir.path}/$fileName.pdf';
    final savedFile = await pdfFile.copy(savedFilePath);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('PDF downloaded successfully'),
          action: SnackBarAction(
            label: 'Open',
            onPressed: () => OpenFile.open(savedFile.path),
          ),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  } catch (e) {
    showSnackBar(context, 'Failed to download PDF: $e');
  }
}

Future<String?> fetchHtmlContent(String url) async {
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      debugPrint('Failed to fetch HTML. Status code: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error fetching HTML content: $e');
  }
  return null;
}

Future<File?> convertHtmlToPdf(
  String htmlContent,
  String outputFileName,
) async {
  try {
    final tempDir = await getTemporaryDirectory();
    final pdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(
      content: htmlContent,
      configuration: PrintPdfConfiguration(
        targetDirectory: tempDir.path,
        targetName: '$outputFileName.pdf',
      ),
    );
    return pdfFile;
  } catch (e) {
    debugPrint('Error converting HTML to PDF: $e');
    return null;
  }
}
