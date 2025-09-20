// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final opacityLevel = useState(0.0);

    SizeConfig.screenHeight = MediaQuery.of(context).size.height;
    SizeConfig.screenWidth = MediaQuery.of(context).size.width;

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 500), () {
        opacityLevel.value = 1.0;
      });

      Future.delayed(const Duration(seconds: 3), () async {
        String token = await getAuthToken();

        if (token.isNotEmpty) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NavigationPage(index: 0)),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const UserLogin()),
          );
        }
      });

      return null;
    }, []);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: AnimatedOpacity(
              opacity: opacityLevel.value,
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.screenHeight * 0.012),
                child: Image.asset(
                  'assets/images/logo.png',
                  height: SizeConfig.screenHeight * 0.30,
                  width: SizeConfig.screenWidth,
                ),
              ),
            ),
          ),
          Text(
            'Distributing  Partner',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: AppFontSize.s14,
              fontWeight: AppFontWeight.w300,
            ),
          ),
          Text(
            'Gandhi TVS Automobiles',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: AppFontSize.s18,
              fontWeight: AppFontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
