// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfPreviewScreen extends HookWidget {
  final String quotationId;
  final String phoneNumber;

  const PdfPreviewScreen({
    super.key,
    required this.quotationId,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    final pdfViewerController = useMemoized(() => PdfViewerController());
    final isLoading = useState(true);
    final hasError = useState(false);
    final errorMessage = useState<String?>(null);
    final pdfBytes = useState<Uint8List?>(null);

    final loadPdf = useCallback(() async {
      try {
        isLoading.value = true;
        hasError.value = false;
        errorMessage.value = null;

        await Future.microtask(() async {
          final bytes = await fetchPdfBytes(context, quotationId);
          if (bytes == null) {
            throw Exception('Failed to load PDF');
          }
          pdfBytes.value = bytes;
        });

        isLoading.value = false;
      } catch (e) {
        isLoading.value = false;
        hasError.value = true;
        errorMessage.value = e.toString();
      }
    }, [quotationId]);

    useEffect(() {
      Future.microtask(() => loadPdf());
      return null;
    }, [loadPdf]);

    Widget buildBody() {
      if (isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (hasError.value) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Failed to load PDF',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              if (errorMessage.value != null) ...[
                const SizedBox(height: 8),
                Text(
                  errorMessage.value!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: loadPdf,
                child: const Text('Try Again'),
              ),
            ],
          ),
        );
      }

      if (pdfBytes.value == null) {
        return const Center(child: Text('No PDF available'));
      }

      return Stack(
        children: [
          SfPdfViewer.memory(
            pdfBytes.value!,
            controller: pdfViewerController,
            canShowScrollHead: true,
            canShowScrollStatus: true,
          ),
          Positioned(
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationPage(index: 1),
                  ),
                );
              },
              child: Container(
                height: SizeConfig.screenHeight * 0.060,
                width: SizeConfig.screenWidth,
                color: AppColors.secondary,
                child: Center(
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: AppColors.surface,
                      fontSize: AppFontSize.s20,
                      fontWeight: AppFontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('PDF Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: loadPdf,
            tooltip: 'Reload PDF',
          ),
          PopupMenuButton<String>(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'print',
                child: ListTile(
                  leading: Icon(Icons.print),
                  title: Text('Print Quotation'),
                ),
              ),
              const PopupMenuItem(
                value: 'download',
                child: ListTile(
                  leading: Icon(Icons.download),
                  title: Text('Download Quotation'),
                ),
              ),
              const PopupMenuItem(
                value: 'share',
                child: ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Share Quotation'),
                ),
              ),
              const PopupMenuItem(
                value: 'share attachments',
                child: ListTile(
                  leading: Icon(FontAwesomeIcons.whatsapp),
                  title: Text('Share Quotation On WhatsApp'),
                ),
              ),
            ],
            onSelected: (value) async {
              switch (value) {
                case 'print':
                  await printPdf(context, quotationId);
                  break;
                case 'download':
                  await downloadPdf(context, quotationId);
                  break;
                case 'share':
                  await sharePdf(context, quotationId);
                  break;
                case 'whatsapp':
                  await sharePdfOnWhatsApp(context, quotationId, phoneNumber);
                  break;
                case 'share attachments':
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SelectAttachments(quotationId: quotationId),
                    ),
                  );
                  break;
              }
            },
          ),
        ],
      ),
      body: buildBody(),
    );
  }
}
