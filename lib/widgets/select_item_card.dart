import 'package:gandhi_tvs/common/app_imports.dart';

class SelectItemCard extends StatelessWidget {
  final String title;
  final bool isSelected;

  const SelectItemCard({
    super.key,
    required this.title,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.p2,
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isSelected ? Colors.blue.shade50 : Colors.white,
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey.shade300,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.blue.shade900 : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
              Icon(
                isSelected ? Icons.check_circle : Icons.circle_outlined,
                size: MediaQuery.of(context).size.height * 0.022,
                color: isSelected ? Colors.blue : Colors.black38,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
