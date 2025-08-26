import 'dart:async';
import 'package:gandhi_tvs/common/app_imports.dart';

class AutoScrollingCarousel extends HookWidget {
  const AutoScrollingCarousel({super.key, required this.images});

  final List<String?> images;

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentPage = useState(0);

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
        if (currentPage.value < images.length - 1) {
          currentPage.value++;
        } else {
          currentPage.value = 0;
        }
        pageController.animateToPage(
          currentPage.value,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      });

      return timer.cancel;
    }, [images.length]);

    return SizedBox(
      height: AppDimensions.height30,
      child: PageView.builder(
        controller: pageController,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(images[index] ?? ""),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
