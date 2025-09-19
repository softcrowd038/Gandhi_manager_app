// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';

Future<void> showFinanceLetterDialog({
  required BuildContext context,
  required String customerName,
  Function(XFile?)? onImageCaptured,
  required String? bookingId,
  required FinanceLetterProvider financeLetterProvider,
  required bool isIndexThree,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      XFile? localFile;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Add Finance Letter'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Add Finance Letter of $customerName'),
                SizedBox(height: 10),
                if (localFile != null)
                  _buildFilePreview(localFile!)
                else
                  Text('No file selected'),
              ],
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.cancel),
                    tooltip: 'Cancel',
                  ),
                  IconButton(
                    onPressed: () async {
                      final capturedImage = await captureImage();
                      if (capturedImage != null) {
                        setState(() {
                          localFile = capturedImage;
                          financeLetterProvider.setFinanceLetter(
                            capturedImage.path,
                          );
                        });
                        if (onImageCaptured != null) {
                          onImageCaptured(capturedImage);
                        }
                      }
                    },
                    icon: Icon(Icons.camera_alt_rounded),
                    tooltip: 'Capture Image',
                  ),
                  IconButton(
                    onPressed: () async {
                      final imageFile = await pickImage();
                      if (imageFile != null) {
                        setState(() {
                          localFile = imageFile;
                          financeLetterProvider.setFinanceLetter(
                            imageFile.path,
                          );
                        });
                        if (onImageCaptured != null) {
                          onImageCaptured(imageFile);
                        }
                      }
                    },
                    icon: Icon(Icons.image),
                    tooltip: 'Pick Image',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () async {
                      final pdfFile = await pickFile();
                      if (pdfFile != null) {
                        setState(() {
                          localFile = pdfFile;
                          financeLetterProvider.setFinanceLetter(pdfFile.path);
                        });
                        if (onImageCaptured != null) {
                          onImageCaptured(pdfFile);
                        }
                      }
                    },
                    icon: Icon(Icons.picture_as_pdf),
                    tooltip: 'Pick PDF',
                  ),

                  IconButton(
                    onPressed: () async {
                      await financeLetterProvider.postKYC(
                        context,
                        financeLetterProvider.financeLetterModel,
                        bookingId ?? "",
                        isIndexThree,
                      );
                    },
                    icon: Icon(Icons.upload),
                    tooltip: 'Upload File',
                  ),
                ],
              ),
            ],
          );
        },
      );
    },
  );
}

Widget _buildFilePreview(XFile file) {
  final path = file.path;
  final isPdf = path.toLowerCase().endsWith('.pdf');
  final fileName = path.split('/').last;

  return Column(
    children: [
      if (isPdf)
        Icon(Icons.picture_as_pdf, size: 50, color: Colors.red)
      else
        Image.file(File(path), height: 100, width: 100, fit: BoxFit.cover),
      SizedBox(height: 8),
      Text(
        fileName,
        style: TextStyle(fontSize: 12),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    ],
  );
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
    return null;
  }
}
