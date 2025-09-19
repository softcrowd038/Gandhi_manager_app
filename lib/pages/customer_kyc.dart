// ignore_for_file: deprecated_member_use

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class CustomerKyc extends HookWidget {
  final String bookingId;
  final String customerName;
  final String address;
  final bool isIndexThree;

  const CustomerKyc({
    super.key,
    required this.bookingId,
    required this.address,
    required this.customerName,
    required this.isIndexThree,
  });

  @override
  Widget build(BuildContext context) {
    final images = useState<List<XFile?>>(
      List<XFile?>.filled(documents.length, null),
    );

    final kycProvider = Provider.of<KYCProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomerHeader(
                customerName: customerName,
                address: address,
                bookingId: bookingId,
              ),
              const SizedBox(height: 10),
              StatefulBuilder(
                builder: (context, setState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: AppPadding.p2,
                        child: ListTile(
                          tileColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppBorderRadius.r2,
                            side: BorderSide(color: AppColors.textSecondary),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  documents[index],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (images.value[index] != null)
                                _buildFilePreview(
                                  images.value[index]!,
                                  index,
                                  context,
                                )
                              else
                                const SizedBox.shrink(),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.camera_alt_rounded),
                                onPressed: () async {
                                  final img = await captureImage();
                                  if (img != null) {
                                    setState(() {
                                      images.value[index] = img;
                                      images.value = List.from(images.value);
                                    });
                                    setKYCField(kycProvider, index, img.path);
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.attach_file),
                                onPressed: () async {
                                  final img = await pickFile();
                                  if (img != null) {
                                    setState(() {
                                      images.value[index] = img;
                                      images.value = List.from(images.value);
                                    });
                                    setKYCField(kycProvider, index, img.path);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              Padding(
                padding: AppPadding.p2,
                child: GestureDetector(
                  onTap: () async {
                    await kycProvider.postKYC(
                      context,
                      kycProvider.kycModel,
                      bookingId,
                      isIndexThree,
                    );
                  },
                  child: Container(
                    height: AppDimensions.height6,
                    width: AppDimensions.fullWidth,
                    decoration: const BoxDecoration(color: AppColors.primary),
                    child: Center(
                      child: Text(
                        "SUBMIT",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppFontSize.s18,
                          fontWeight: AppFontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilePreview(XFile file, int index, BuildContext context) {
    final fileName = file.path.split('/').last;
    final isPdf = fileName.toLowerCase().endsWith('.pdf');

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Display file name with limited width
        SizedBox(
          width: 60, // Reduced width to prevent overflow
          child: Text(
            fileName,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: AppFontSize.s10, // Smaller font size
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: 4),

        // Preview button for PDF files
        if (isPdf)
          IconButton(
            icon: Icon(Icons.preview, size: 18), // Smaller icon
            onPressed: () {
              _showPdfPreview(context, file.path, documents[index]);
            },
          ),

        // For image files, show smaller thumbnail
        if (!isPdf)
          Container(
            height: AppDimensions.height4, // Smaller dimensions
            width: AppDimensions.height6,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.textSecondary.withOpacity(0.3),
              ),
            ),
            child: Image.file(File(file.path), fit: BoxFit.cover),
          ),
      ],
    );
  }

  void _showPdfPreview(
    BuildContext context,
    String filePath,
    String documentName,
  ) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Header with document name and close button
            Container(
              padding: EdgeInsets.all(16),
              color: AppColors.primary,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      documentName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: AppFontSize.s16,
                        fontWeight: AppFontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
            ),

            // PDF preview
            Expanded(
              child: SfPdfViewer.file(
                File(filePath),
                canShowScrollHead: true,
                canShowScrollStatus: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
