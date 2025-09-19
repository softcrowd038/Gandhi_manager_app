import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class VerifyFinanceLetter extends StatefulWidget {
  final String? bookingId;
  final bool isIndexThree;
  const VerifyFinanceLetter({
    super.key,
    required this.bookingId,
    required this.isIndexThree,
  });

  @override
  State<VerifyFinanceLetter> createState() => _VerifyKycPageState();
}

class _VerifyKycPageState extends State<VerifyFinanceLetter> {
  late final GetFinanceLetterProvider _financeLetterProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _financeLetterProvider.fetchFinanceLetters(context, widget.bookingId);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _financeLetterProvider = context.read<GetFinanceLetterProvider>();
  }

  bool _isPdfFile(String url) {
    return url.toLowerCase().endsWith('.pdf');
  }

  void _openFullScreenDocument(
    BuildContext context,
    String documentUrl,
    String title,
  ) {
    if (_isPdfFile(documentUrl)) {
      // Open PDF viewer
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PdfViewerScreen(pdfUrl: documentUrl, title: title),
        ),
      );
    } else {
      // Open image in full screen
      showDialog(
        context: context,
        builder: (context) => Dialog(
          insetPadding: EdgeInsets.zero,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: AppFontSize.s16,
                      fontWeight: AppFontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: InteractiveViewer(
                    panEnabled: true,
                    boundaryMargin: EdgeInsets.all(20),
                    minScale: 0.5,
                    maxScale: 4,
                    child: Image.network(documentUrl, fit: BoxFit.contain),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Close'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Consumer<GetFinanceLetterProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (provider.errorMessage != null) {
            return Center(child: Text('Error: ${provider.errorMessage}'));
          }

          final financeLetterUrl =
              "$baseImageUrl${provider.getFinanceLetterModel?.data.financeLetter}";
          final isPdf = _isPdfFile(financeLetterUrl);

          return Column(
            children: [
              // Header section
              CustomerHeader(
                customerName:
                    "${provider.getFinanceLetterModel?.data.customerName}",
                address: DateFormat('yyyy-MM-dd').format(
                  provider.getFinanceLetterModel?.data.createdAt ??
                      DateTime.now(),
                ),
                bookingId: provider.getFinanceLetterModel?.data.status ?? "",
              ),

              // Approval buttons row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  provider.getFinanceLetterModel?.data.status != "APPROVED"
                      ? Padding(
                          padding: AppPadding.p2,
                          child: GestureDetector(
                            onTap: () {
                              final verifyKyc =
                                  Provider.of<VerifyFinanceLetterProvider>(
                                    context,
                                    listen: false,
                                  );

                              verifyKyc.verifyFinanceLetter(
                                context,
                                provider.getFinanceLetterModel?.data.bookingId,
                                "APPROVED",
                                widget.isIndexThree,
                              );
                            },
                            child: Container(
                              height: AppDimensions.height5,
                              width: AppDimensions.width40,
                              decoration: const BoxDecoration(
                                color: AppColors.primary,
                              ),
                              child: Center(
                                child: Text(
                                  "Approve",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: AppFontSize.s18,
                                    fontWeight: AppFontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: AppPadding.p2,
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Finance Letter is already Approved",
                                  ),
                                  backgroundColor: AppColors.error,
                                ),
                              );
                            },
                            child: Container(
                              height: AppDimensions.height5,
                              width: AppDimensions.width40,
                              decoration: const BoxDecoration(
                                color: AppColors.disabled,
                              ),
                              child: Center(
                                child: Text(
                                  "Approve",
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
                  provider.getFinanceLetterModel?.data.status != "APPROVED" ||
                          provider.getFinanceLetterModel?.data.status ==
                              "REJECTED"
                      ? Padding(
                          padding: AppPadding.p2,
                          child: GestureDetector(
                            onTap: () {
                              final verifyKyc =
                                  Provider.of<VerifyFinanceLetterProvider>(
                                    context,
                                    listen: false,
                                  );

                              verifyKyc.verifyFinanceLetter(
                                context,
                                provider.getFinanceLetterModel?.data.bookingId,
                                "REJECTED",
                                widget.isIndexThree,
                              );
                            },
                            child: Container(
                              height: AppDimensions.height5,
                              width: AppDimensions.width40,
                              decoration: const BoxDecoration(
                                color: AppColors.error,
                              ),
                              child: Center(
                                child: Text(
                                  "Reject",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: AppFontSize.s18,
                                    fontWeight: AppFontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: AppPadding.p2,
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Finance Letter is already Rejected",
                                  ),
                                  backgroundColor: AppColors.error,
                                ),
                              );
                            },
                            child: Container(
                              height: AppDimensions.height5,
                              width: AppDimensions.width40,
                              decoration: const BoxDecoration(
                                color: AppColors.disabled,
                              ),
                              child: Center(
                                child: Text(
                                  "Reject",
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
              const Divider(),

              // Document display section - Now takes remaining space
              Expanded(
                child: Container(
                  padding: AppPadding.p2,
                  child: GestureDetector(
                    onTap: () => _openFullScreenDocument(
                      context,
                      financeLetterUrl,
                      "Finance Letter",
                    ),
                    child:
                        provider.getFinanceLetterModel?.data.financeLetter !=
                            null
                        ? isPdf
                              ? Container(
                                  width: AppDimensions.fullWidth,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.picture_as_pdf,
                                        size: 64,
                                        color: Colors.red,
                                      ),
                                      SizedBox(height: 16),
                                      Text(
                                        'PDF Document',
                                        style: TextStyle(
                                          fontSize: AppFontSize.s16,
                                          fontWeight: AppFontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        'Tap to view',
                                        style: TextStyle(
                                          fontSize: AppFontSize.s12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Image.network(
                                  financeLetterUrl,
                                  fit: BoxFit.contain,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Center(
                                          child: CircularProgressIndicator(
                                            value:
                                                loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                : null,
                                          ),
                                        );
                                      },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.error,
                                            size: 48,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(height: 8),
                                          Text('Failed to load image'),
                                        ],
                                      ),
                                    );
                                  },
                                )
                        : Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'No Finance Letter Available',
                                style: TextStyle(
                                  fontSize: AppFontSize.s16,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
