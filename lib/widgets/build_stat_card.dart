import 'package:gandhi_tvs/common/app_imports.dart';

class BuildStatCard extends HookWidget {
  final String title;
  final String value;
  final String imageSource;
  final String subTitle;

  const BuildStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.imageSource,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: height * 0.008,
        vertical: height * 0.004,
      ),
      child: Container(
        width: width * 0.45,
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black26),
        ),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(height * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: height * 0.022,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: height * 0.018,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(
                      fontSize: height * 0.014,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 35,
              left: 140,
              child: Image.network(
                imageSource,
                height: height * 0.05,
                width: width * 0.08,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
