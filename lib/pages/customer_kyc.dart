// ignore_for_file: deprecated_member_use

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

class CustomerKyc extends HookWidget {
  final String bookingId;
  final String customerName;
  final String address;

  const CustomerKyc({
    super.key,
    required this.bookingId,
    required this.address,
    required this.customerName,
  });

  @override
  Widget build(BuildContext context) {
    final images = useState<List<XFile?>>(
      List<XFile?>.filled(documents.length, null),
    );

    final kycProvider = Provider.of<KYCProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomerHeader(
                customerName: customerName,
                address: address,
                bookingId: bookingId,
              ),
              const SizedBox(height: 10),
              StatefulBuilder(
                builder: (context, setState) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: documents.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: AppPadding.p2,
                        child: ListTile(
                          tileColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: AppBorderRadius.r2,
                            side: BorderSide(color: AppColors.textSecondary),
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(documents[index]),
                              images.value[index] != null
                                  ? Image.file(
                                      File(images.value[index]!.path),
                                      height: AppDimensions.height5,
                                      width: AppDimensions.height8,
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.camera_alt_rounded),
                                onPressed: () async {
                                  final img = await captureImage();
                                  if (img != null) {
                                    setState(() {
                                      images.value[index] = img;
                                      images.value = List.from(images.value);
                                    });
                                    setKYCField(kycProvider, index, img.path);
                                  }
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.image),
                                onPressed: () async {
                                  final img = await pickImage();
                                  if (img != null) {
                                    setState(() {
                                      images.value[index] = img;
                                      images.value = List.from(images.value);
                                      print(img.path);
                                      print(index);
                                    });
                                    setKYCField(kycProvider, index, img.path);
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              Padding(
                padding: AppPadding.p2,
                child: GestureDetector(
                  onTap: () async {
                    await kycProvider.postKYC(
                      context,
                      kycProvider.kycModel,
                      bookingId,
                    );
                  },
                  child: Container(
                    height: AppDimensions.height6,
                    width: AppDimensions.fullWidth,
                    decoration: const BoxDecoration(color: AppColors.primary),
                    child: Center(
                      child: Text(
                        "SUBMIT",
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
        ),
      ),
    );
  }
}
