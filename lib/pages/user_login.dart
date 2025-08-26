import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

class UserLogin extends HookWidget {
  const UserLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final mobileController = useTextEditingController(text: '');

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/images/login.json',
                height: AppDimensions.height40,
              ),
              Text(
                'Mobile Verification',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppFontSize.s24,
                  fontWeight: AppFontWeight.w600,
                ),
              ),
              SizedBox(height: AppDimensions.height1),
              Text(
                'Please enter your mobile number',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: AppFontSize.s16,
                  fontWeight: AppFontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: AppDimensions.height8,
                        horizontal: AppDimensions.width5,
                      ),
                      child: MobileTextFieldWidget(
                        mobileController: mobileController,
                      ),
                    ),
                    SizedBox(height: AppDimensions.height8),
                    Consumer<UserLoginProvider>(
                      builder: (context, userLoginProvider, _) {
                        return GestureDetector(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              final mobile = mobileController.text.trim();
                              userLoginProvider.setMobile(mobile);
                              userLoginProvider.login(mobile, context);
                            }
                          },
                          child: userLoginProvider.isLoading
                              ? CircularProgressIndicator(
                                  color: Color(0xFF4965e9),
                                )
                              : ButtonWidget(
                                  height: 0.09,
                                  width: 0.09,
                                  textFontSize: 0.04,
                                  color: Color(0xFF4965e9),
                                ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
