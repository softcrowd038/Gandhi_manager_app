// ignore_for_file: avoid_print, deprecated_member_use, use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SelectAttachments extends HookWidget {
  final String quotationId;

  const SelectAttachments({super.key, required this.quotationId});

  @override
  Widget build(BuildContext context) {
    final selectedAttachments = useState<List<String>>([]);
    final isSelectingMode = useState<bool>(false);
    final whatsAppService = WhatsAppApiService();
    final videoControllers = useState<Map<String, VideoPlayerController>>({});
    final chewieControllers = useState<Map<String, ChewieController>>({});
    final thumbnailCache = useState<Map<String, ImageProvider>>({});

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<QuotationProvider>(
          context,
          listen: false,
        ).fetchQuotationById(quotationId, context);
      });

      return () {
        for (var controller in videoControllers.value.values) {
          controller.dispose();
        }
        for (var controller in chewieControllers.value.values) {
          controller.dispose();
        }
      };
    }, []);

    Future<File> downloadFile(String url, String filename) async {
      final response = await http.get(Uri.parse(url));
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/$filename');
      await file.writeAsBytes(response.bodyBytes);
      return file;
    }

    Widget buildPdfPreview(String url) {
      return FutureBuilder<File>(
        future: downloadFile(
          url,
          'preview_${DateTime.now().millisecondsSinceEpoch}.pdf',
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return PDFView(
              filePath: snapshot.data!.path,
              enableSwipe: true,
              swipeHorizontal: false,
              autoSpacing: false,
              pageFling: false,
              onError: (error) => print('PDF Error: $error'),
              onPageError: (page, error) => print('Page $page Error: $error'),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Icon(Icons.error));
          }
          return const Center(child: CircularProgressIndicator());
        },
      );
    }

    Widget buildVideoPreview(String url) {
      if (!thumbnailCache.value.containsKey(url)) {
        thumbnailCache.value[url] = const AssetImage(
          'assets/video_placeholder.png',
        );
      }

      return Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (!isSelectingMode.value) {
                if (!videoControllers.value.containsKey(url)) {
                  final controller = VideoPlayerController.network(
                    url,
                    formatHint: VideoFormat.other,
                  );

                  videoControllers.value[url] = controller;
                  controller.initialize().then((_) {
                    if (controller.value.isInitialized) {
                      chewieControllers.value[url] = ChewieController(
                        videoPlayerController: controller,
                        autoPlay: false,
                        looping: false,
                        aspectRatio: controller.value.aspectRatio,
                        showControls: true,
                        materialProgressColors: ChewieProgressColors(
                          playedColor: Colors.red,
                          handleColor: Colors.red,
                          backgroundColor: Colors.grey,
                          bufferedColor: Colors.grey.withOpacity(0.5),
                        ),
                      );
                    }
                  });
                }
              }
            },
            child: videoControllers.value.containsKey(url)
                ? Chewie(controller: chewieControllers.value[url]!)
                : Image(
                    image: thumbnailCache.value[url]!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.videocam),
                  ),
          ),
        ],
      );
    }

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
              final quotation = provider.quotation;
              return isSelectingMode.value ||
                      quotation == null ||
                      quotation.data.attachments.isEmpty
                  ? IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () async {
                        final response = await whatsAppService
                            .sendQuotationOnWhatsApp(
                              context,
                              quotationId,
                              imageLinks: selectedAttachments.value,
                            );
                        if (response != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Sent successfully via WhatsApp'),
                            ),
                          );
                        }
                      },
                    )
                  : const SizedBox.shrink();
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
          final allAttachments = quotation.data.attachments
              .expand(
                (group) =>
                    group.attachments.where((item) => item.type != 'youtube'),
              )
              .toList();

          return GridView.builder(
            itemCount: allAttachments.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 0.9,
            ),
            padding: AppPadding.p2,
            itemBuilder: (context, index) {
              final item = allAttachments[index];
              final fileUrl = '$baseImageUrl/public${item.url}';
              final isSelected = selectedAttachments.value.contains(fileUrl);

              Widget previewWidget;

              switch (item.type) {
                case 'image':
                  previewWidget = Image.network(
                    fileUrl,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image),
                  );
                  break;
                case 'video':
                  previewWidget = buildVideoPreview(fileUrl);
                  break;
                case 'document':
                case 'pdf':
                case 'docx':
                  previewWidget = buildPdfPreview(fileUrl);
                  break;
                default:
                  previewWidget = Container(
                    color: Colors.grey[300],
                    child: const Center(child: Text("Unsupported type")),
                  );
              }

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
                  } else if (item.type == 'video') {}
                },
                child: Stack(
                  children: [
                    Container(
                      height: AppDimensions.height30,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: previewWidget,
                    ),
                    if (isSelected)
                      const Positioned(
                        top: 8,
                        right: 8,
                        child: Icon(Icons.check_circle, color: Colors.blue),
                      ),
                    Container(
                      height: AppDimensions.height30,
                      width: AppDimensions.width50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(AppFontSize.s10),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: AppFontSize.s10,
                            left: AppFontSize.s10,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppFontSize.s10,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black54,
                                borderRadius: BorderRadius.circular(
                                  AppFontSize.s10,
                                ),
                              ),
                              child: Text(
                                item.type?.toUpperCase() ?? "",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
