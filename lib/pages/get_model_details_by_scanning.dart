// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

class GetModelDetailsByScanning extends StatefulWidget {
  const GetModelDetailsByScanning({super.key});

  @override
  State<GetModelDetailsByScanning> createState() =>
      _GetModelDetailsByScanningState();
}

class _GetModelDetailsByScanningState extends State<GetModelDetailsByScanning> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qrText;
  bool isProcessing = false;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Check Model Details",
          style: TextStyle(
            fontSize: AppFontSize.s20,
            fontWeight: AppFontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
      ),
      body: Consumer<GetInwardModelDetailsQr>(
        builder: (context, getInward, _) {
          return Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: (ctrl) {
                    controller = ctrl;
                    controller!.scannedDataStream.listen((scanData) async {
                      if (!isProcessing) {
                        isProcessing = true;

                        controller!.pauseCamera();
                        setState(() {
                          qrText = scanData.code;
                        });

                        final getInwardProvider =
                            Provider.of<GetInwardModelDetailsQr>(
                              context,
                              listen: false,
                            );
                        await getInwardProvider.fetchInwardBikeDetails(
                          context,
                          qrText,
                        );

                        showInwardDetailsBottomSheet(context, true);

                        await Future.delayed(const Duration(seconds: 1));

                        isProcessing = false;
                        controller!.resumeCamera();
                      }
                    });
                  },
                  overlay: QrScannerOverlayShape(
                    borderColor: Colors.blue,
                    borderRadius: 10,
                    borderLength: 30,
                    borderWidth: 10,
                    cutOutSize: 250,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
