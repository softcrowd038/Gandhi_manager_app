import 'package:gandhi_tvs/common/app_imports.dart';

class KycGridItem extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final bool isPdf;
  final VoidCallback onTap;

  const KycGridItem({
    super.key,
    required this.title,
    this.imageUrl,
    this.isPdf = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: isPdf
                  ? Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.picture_as_pdf,
                        size: 64,
                        color: Colors.red,
                      ),
                    )
                  : imageUrl != null
                  ? Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error);
                      },
                    )
                  : Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.error),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (isPdf)
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  "PDF Document",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
