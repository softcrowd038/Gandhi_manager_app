// ignore_for_file: avoid_print

import 'package:image_picker/image_picker.dart';

Future<XFile?> captureImage() async {
  try {
    ImagePicker imagePicker = ImagePicker();
    final XFile? scannedPath = await imagePicker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);

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

Future<XFile?> pickImage() async {
  ImagePicker imagePicker = ImagePicker();
  final imageFile = await imagePicker.pickImage(source: ImageSource.gallery);

  return imageFile;
}
