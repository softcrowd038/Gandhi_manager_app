// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';

void toggleAttachment(
  String attachmentUrl,
  ValueNotifier<List<String>> selectedAttachments,
  ValueNotifier<bool> isSelectingMode,
) {
  final current = selectedAttachments.value;
  if (current.contains(attachmentUrl)) {
    selectedAttachments.value = current
        .where((url) => url != attachmentUrl)
        .toList();

    if (selectedAttachments.value.isEmpty) {
      isSelectingMode.value = false;
    }
  } else {
    selectedAttachments.value = [...current, attachmentUrl];

    if (!isSelectingMode.value) {
      isSelectingMode.value = true;
    }
  }
}

void handleLongPress(
  String attachmentUrl,
  ValueNotifier<List<String>> selectedAttachments,
  ValueNotifier<bool> isSelectingMode,
) {
  if (!isSelectingMode.value) {
    isSelectingMode.value = true;
    selectedAttachments.value = [attachmentUrl];
  } else {
    toggleAttachment(attachmentUrl, selectedAttachments, isSelectingMode);
  }
}

Future<void> shareSelectedAttachments(
  BuildContext context,
  String mobile,
  String pdfUrl,
  String video,
  String youtube,
  ValueNotifier<List<String>> selectedAttachments,
  bool isNoAttachmentsAvialable,
  ValueNotifier<bool> isSelectingMode,
) async {
  if (selectedAttachments.value.isEmpty && !isNoAttachmentsAvialable) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please select at least one attachment')),
    );
    return;
  }

  final loadingSnackBar = ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Row(
        children: [
          CircularProgressIndicator(),
          SizedBox(width: 16),
          Text('Sending attachments...'),
        ],
      ),
      duration: Duration(seconds: 30),
    ),
  );

  try {
    final whatsAppService = WhatsAppApiService();
    final response = await whatsAppService.sendWhatsAppMessage(
      apiKey: apikey,
      mobile: mobile,
      message: message,
      pdfUrl: pdfUrl,
      imageUrls: selectedAttachments.value,
      video: video,
      youtube: youtube,
    );

    loadingSnackBar.close();

    if (response['status'] == 'error') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send: ${response['message']}')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Attachments sent successfully!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NavigationPage(index: 1)),
      );
      isSelectingMode.value = false;
      selectedAttachments.value = [];
    }
  } catch (e) {
    loadingSnackBar.close();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error: ${e.toString()}')));
  }
}

void cancelSelection(
  ValueNotifier<List<String>> selectedAttachments,
  ValueNotifier<bool> isSelectingMode,
) {
  isSelectingMode.value = false;
  selectedAttachments.value = [];
}
