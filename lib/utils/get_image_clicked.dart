// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';

Future<XFile?> captureImage() async {
  try {
    ImagePicker imagePicker = ImagePicker();
    final XFile? scannedPath = await imagePicker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );

    if (scannedPath != null) {
      return XFile(scannedPath.path);
    } else {
      return null;
    }
  } catch (e) {
    print("Document scanning failed: $e");
    return null;
  }
}

// Function to pick PDF files only
Future<XFile?> pickFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: false,
      dialogTitle: 'Select PDF Document',
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      if (file.path != null) {
        return XFile(file.path!);
      }
    }
  } catch (e) {
    print('Error picking file: $e');
    // You might want to show a snackbar or dialog here
  }
  return null;
}

// Function to preview files (PDF or images)
void previewFile(BuildContext context, XFile file) async {
  final path = file.path;
  final isPdf = path.toLowerCase().endsWith('.pdf');

  if (isPdf) {
    // Open PDF with default viewer
    try {
      await OpenFile.open(path);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cannot open PDF file: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } else {
    // Preview image
    showDialog(
      context: context,
      builder: (context) =>
          Dialog(child: Image.file(File(path), fit: BoxFit.contain)),
    );
  }
}

Future<XFile?> pickImage() async {
  ImagePicker imagePicker = ImagePicker();
  final imageFile = await imagePicker.pickImage(source: ImageSource.gallery);

  return imageFile;
}
