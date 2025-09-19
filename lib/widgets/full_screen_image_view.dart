// ignore_for_file: file_names

import 'package:gandhi_tvs/common/app_imports.dart';

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;
  final String title;

  const FullScreenImagePage({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return _FullScreenShimmer();
            },
            errorBuilder: (_, __, ___) => const Center(
              child: Icon(Icons.error_outline, size: 50, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class _FullScreenShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[800]!,
      highlightColor: Colors.grey[600]!,
      child: Container(
        color: Colors.grey[800],
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
