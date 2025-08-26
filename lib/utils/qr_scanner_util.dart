import 'package:gandhi_tvs/common/app_imports.dart';

void onQRViewCreatedReusable(
  BuildContext context,
  QRViewController controller,
  Function(String?) onScanned,
) {
  controller.scannedDataStream.listen((scanData) {
    onScanned(scanData.code);
  });
}
