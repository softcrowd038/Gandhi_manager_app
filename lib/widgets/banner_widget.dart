import 'dart:async';
import 'package:gandhi_tvs/common/app_imports.dart';

class BannerWidget extends HookWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentPage = useState(0);

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 8), (Timer timer) {
        if (currentPage.value < bannerImages.length - 1) {
          currentPage.value++;
        } else {
          currentPage.value = 0;
        }
        pageController.animateToPage(
          currentPage.value,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });

      return () {
        timer.cancel();
      };
    }, [bannerImages.length]);

    return SizedBox(
      height: AppDimensions.height15,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: pageController,
        itemCount: bannerImages.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(bannerImages[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
