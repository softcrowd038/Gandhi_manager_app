import 'package:gandhi_tvs/common/app_imports.dart';

class CustomerCard extends HookWidget {
  final String customerName;
  final String customerAddress;
  final String customerExpectedDate;
  final Function() onTap;

  const CustomerCard({
    super.key,
    required this.customerName,
    required this.customerAddress,
    required this.customerExpectedDate,
    required this.onTap,
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
                    customerAddress,
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
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
            GestureDetector(
              onTap: onTap,
              child: Icon(
                Icons.call,
                size: height * 0.024,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
