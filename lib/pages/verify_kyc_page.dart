import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

class VerifyKycPage extends StatefulWidget {
  final String? bookingId;
  final bool isIndexThree;
  const VerifyKycPage({
    super.key,
    required this.bookingId,
    required this.isIndexThree,
  });

  @override
  State<VerifyKycPage> createState() => _VerifyKycPageState();
}

class _VerifyKycPageState extends State<VerifyKycPage> {
  late final VerifyKycProvider _kycProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _kycProvider.fetchKycDocuments(context, widget.bookingId);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _kycProvider = context.read<VerifyKycProvider>();
  }

  List<Map<String, dynamic>> _getDocuments() {
    final docs = _kycProvider.kycModel?.data.kycDocuments;
    if (docs == null) return const [];

    return [
      {"title": "Aadhar Front", "file": docs.aadharFront.original},
      {"title": "Aadhar Back", "file": docs.aadharBack.original},
      {"title": "PAN Card", "file": docs.panCard.original},
      {"title": "Photo", "file": docs.vPhoto.original},
      {"title": "Chassis No Photo", "file": docs.chasisNoPhoto.original},
      {"title": "Address Proof 1", "file": docs.addressProof1.original},
      {"title": "Address Proof 2", "file": docs.addressProof2.original},
    ].where((doc) => doc["file"] != null).toList(growable: false);
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
      // Open image viewer
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              FullScreenImagePage(imageUrl: documentUrl, title: title),
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
      body: Consumer<VerifyKycProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return _buildShimmerGrid();
          }

          if (provider.errorMessage != null) {
            return Center(child: Text('Error: ${provider.errorMessage}'));
          }

          final documents = _getDocuments();

          if (documents.isEmpty) {
            return const Center(child: Text("No documents available"));
          }

          return Padding(
            padding: AppPadding.p2,
            child: Column(
              children: [
                CustomerHeader(
                  customerName:
                      "${provider.kycModel?.data.bookingDetails.customerName}",
                  address:
                      provider.kycModel?.data.bookingDetails.model.modelName ??
                      "",
                  bookingId:
                      provider.kycModel?.data.bookingDetails.bookingNumber ??
                      "",
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: AppPadding.p2,
                      child: GestureDetector(
                        onTap: () {
                          final verifyKyc =
                              Provider.of<VerifyKycDocumentProvider>(
                                context,
                                listen: false,
                              );

                          verifyKyc.verifyKyc(
                            context,
                            provider.kycModel?.data.bookingDetails.bookingId,
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
                    ),
                    Padding(
                      padding: AppPadding.p2,
                      child: GestureDetector(
                        onTap: () {
                          final verifyKyc =
                              Provider.of<VerifyKycDocumentProvider>(
                                context,
                                listen: false,
                              );

                          verifyKyc.verifyKyc(
                            context,
                            provider.kycModel?.data.bookingDetails.bookingId,
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
                    ),
                  ],
                ),
                const Divider(),

                Expanded(
                  child: Padding(
                    padding: AppPadding.p2,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.8,
                          ),
                      itemCount: documents.length,
                      itemBuilder: (context, index) {
                        final document = documents[index];
                        final documentUrl = "$baseImageUrl${document["file"]}";
                        final isPdf = _isPdfFile(documentUrl);

                        return KycGridItem(
                          title: document["title"] as String,
                          imageUrl: isPdf ? null : documentUrl,
                          isPdf: isPdf,
                          onTap: () => _openFullScreenDocument(
                            context,
                            documentUrl,
                            document["title"] as String,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerGrid() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return ShimmerGridItem();
        },
      ),
    );
  }
}
