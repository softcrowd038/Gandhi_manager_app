import 'package:gandhi_tvs/common/app_imports.dart';

Future<void> showFinanceLetterDialog({
  required BuildContext context,
  required String customerName,
  Function(XFile?)? onImageCaptured,
  required String? bookingId,
  required FinanceLetterProvider financeLetterProvider,
}) async {
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      XFile? localImagePath;

      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Add Finance Letter'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Add Finance Letter of $customerName'),
                SizedBox(height: 10),
                localImagePath != null
                    ? Image.file(
                        File(localImagePath?.path ?? ""),
                        height: AppDimensions.height10,
                        width: AppDimensions.width50,
                      )
                    : Text('No image selected'),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.cancel),
              ),
              IconButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final capturedImage = await picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (capturedImage != null) {
                    setState(() {
                      localImagePath = capturedImage;
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
              ),
              IconButton(
                onPressed: () async {
                  final ImagePicker picker = ImagePicker();
                  final capturedImage = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (capturedImage != null) {
                    setState(() {
                      localImagePath = capturedImage;
                      financeLetterProvider.setFinanceLetter(
                        capturedImage.path,
                      );
                    });
                    if (onImageCaptured != null) {
                      onImageCaptured(capturedImage);
                    }
                  }
                },
                icon: Icon(Icons.image),
              ),
              IconButton(
                onPressed: () async {
                  await financeLetterProvider.postKYC(
                    context,
                    financeLetterProvider.financeLetterModel,
                    bookingId ?? "",
                  );
                },
                icon: Icon(Icons.upload),
              ),
            ],
          );
        },
      );
    },
  );
}
