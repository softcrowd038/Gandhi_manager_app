import 'package:gandhi_tvs/common/app_imports.dart';

class ActivityCard extends HookWidget {
  final String customerName;
  final String modelName;
  final String customerAddress;
  final String customerExpectedDate;
  final String quotationId;
  final String phoneNumber;

  const ActivityCard({
    super.key,
    required this.customerName,
    required this.modelName,
    required this.customerAddress,
    required this.customerExpectedDate,
    required this.quotationId,
    required this.phoneNumber,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return Padding(
      padding: AppPadding.p2,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(1, 1),
              color: Colors.black26,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customerName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    modelName,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    customerAddress,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.circle,
                        color: AppColors.themeColor,
                        size: height * 0.012,
                      ),
                      SizedBox(width: height * 0.008),
                      Text(
                        customerExpectedDate,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            PopupMenuButton<String>(
              color: AppColors.surface,
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'print',
                  child: ListTile(
                    leading: Icon(Icons.print),
                    title: Text('Print Quotation'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'download',
                  child: ListTile(
                    leading: Icon(Icons.download),
                    title: Text('Download Quotation'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'share',
                  child: ListTile(
                    leading: Icon(Icons.share),
                    title: Text('Share Quotation'),
                  ),
                ),
                const PopupMenuItem(
                  value: 'share attachments',
                  child: ListTile(
                    leading: Icon(FontAwesomeIcons.whatsapp),
                    title: Text('Share Quotation On WhatsApp'),
                  ),
                ),
              ],
              onSelected: (value) async {
                switch (value) {
                  case 'print':
                    await printPdf(context, quotationId);
                    break;
                  case 'download':
                    await downloadPdf(context, quotationId);
                    break;
                  case 'share':
                    await sharePdf(context, quotationId);
                    break;
                  case 'whatsapp':
                    await sharePdfOnWhatsApp(context, quotationId, phoneNumber);
                    break;
                  case 'share attachments':
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SelectAttachments(quotationId: quotationId),
                      ),
                    );
                    break;
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
