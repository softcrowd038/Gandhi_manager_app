// ignore_for_file: deprecated_member_use, use_build_context_synchronously
import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:gandhi_tvs/models/quotation_model.dart';
import 'package:provider/provider.dart';

class SelectAttachments extends HookWidget {
  final String quotationId;

  const SelectAttachments({super.key, required this.quotationId});

  @override
  Widget build(BuildContext context) {
    final selectedAttachments = useState<List<String>>([]);
    final isSelectingMode = useState<bool>(false);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final attachments = Provider.of<QuotationProvider>(
          context,
          listen: false,
        );
        attachments.fetchQuotationById(quotationId, context);
      });
      return null;
    }, []);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: isSelectingMode.value
            ? Text('${selectedAttachments.value.length} selected')
            : const Text('Attachments'),
        leading: isSelectingMode.value
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () =>
                    cancelSelection(selectedAttachments, isSelectingMode),
              )
            : null,
        actions: [
          Consumer<QuotationProvider>(
            builder: (context, provider, child) {
              AttachmentAttachment? videoAttachment;
              AttachmentAttachment? youtubeAttachment;

              try {
                videoAttachment = provider.quotation?.data.attachments
                    .expand((a) => a.attachments)
                    .firstWhere((a) => a.type == 'video');
              } catch (_) {
                videoAttachment = null;
              }

              try {
                youtubeAttachment = provider.quotation?.data.attachments
                    .expand((a) => a.attachments)
                    .firstWhere((a) => a.type == 'youtube');
              } catch (_) {
                youtubeAttachment = null;
              }

              final quotation = provider.quotation;
              return isSelectingMode.value ||
                      quotation == null ||
                      quotation.data.attachments.isEmpty
                  ? IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () => shareSelectedAttachments(
                        context,
                        provider.quotation?.data.customerDetails.mobile1 ?? '',
                        provider.quotation?.data.pdfUrl ?? '',
                        videoAttachment?.url ?? "",
                        youtubeAttachment?.url ?? "",
                        selectedAttachments,
                        quotation?.data.attachments.isEmpty ?? false,
                        isSelectingMode,
                      ),
                    )
                  : SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<QuotationProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final quotation = provider.quotation;
          if (quotation == null || quotation.data.attachments.isEmpty) {
            return const Center(child: Text('No attachments available'));
          }

          return Column(
            children: [
              Text(
                'Select any 4 attachments only',
                style: TextStyle(color: AppColors.error),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: quotation.data.attachments.length,
                  itemBuilder: (context, index) {
                    final attachment = quotation.data.attachments[index];

                    return Column(
                      children: attachment.attachments.map((item) {
                        final fileUrl = '$baseImageUrl/public${item.url}';
                        final isSelected = selectedAttachments.value.contains(
                          fileUrl,
                        );

                        return GestureDetector(
                          onLongPress: () => handleLongPress(
                            fileUrl,
                            selectedAttachments,
                            isSelectingMode,
                          ),
                          onTap: () {
                            if (isSelectingMode.value) {
                              toggleAttachment(
                                fileUrl,
                                selectedAttachments,
                                isSelectingMode,
                              );
                            }
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: item.type == 'image'
                                    ? Container(
                                        height: 200,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1),
                                          borderRadius: BorderRadius.circular(
                                            SizeConfig.screenHeight * 0.008,
                                          ),
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: Image.network(
                                          fileUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return const Icon(
                                                  Icons.broken_image,
                                                );
                                              },
                                        ),
                                      )
                                    : SizedBox.shrink(),
                              ),
                              if (isSelected)
                                const Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Colors.blue,
                                  ),
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
