// ignore_for_file: use_build_context_synchronously

import 'package:gandhi_tvs/common/app_imports.dart';
import 'package:provider/provider.dart';

class OtpVerification extends HookWidget {
  const OtpVerification({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final otpControllers = useState<List<String>>(List.filled(6, ''));

    return Consumer<OtpVerificationProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: AppColors.surface,
          appBar: AppBar(
            backgroundColor: AppColors.surface,
            automaticallyImplyLeading: true,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UserLogin()),
                );
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height * 0.016,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/images/otp.json',
                    height: AppDimensions.height30,
                  ),
                  SizedBox(height: AppDimensions.height3),
                  Text(
                    'Enter OTP',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppFontSize.s24,
                      fontWeight: AppFontWeight.w600,
                    ),
                  ),
                  SizedBox(height: AppDimensions.height1),
                  Text(
                    'We have sent you an OTP to your \n registered Mobile number',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: AppFontSize.s16,
                      fontWeight: AppFontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppDimensions.height4),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        OtpVerificationField(
                          otpLength: 6,
                          onChanged: (value) {
                            int index = otpControllers.value.indexWhere(
                              (element) => element.isEmpty,
                            );
                            if (index != -1) {
                              otpControllers.value[index] = value;
                            }
                          },
                        ),
                        SizedBox(height: AppDimensions.height4),
                        GestureDetector(
                          onTap: () async {
                            final otp = otpControllers.value.join();
                            await provider.verifyOtp(otp, context);

                            if (provider.otpResponse?['status'] == 'success') {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NavigationPage(index: 0),
                                ),
                              );
                            }
                          },
                          child: provider.isLoading
                              ? const CircularProgressIndicator()
                              : ButtonWidget(
                                  height: 0.09,
                                  width: 0.09,
                                  textFontSize: 0.04,
                                  color: const Color(0xFF4965e9),
                                ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: AppDimensions.height3),
                  Text(
                    'Didn\'t receive the OTP?',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: AppFontSize.s16,
                      fontWeight: AppFontWeight.w400,
                    ),
                  ),
                  SizedBox(height: AppDimensions.height1),
                  Consumer<UserLoginProvider>(
                    builder: (context, user, _) {
                      return GestureDetector(
                        onTap: () {
                          final mobile = user.mobile;
                          user.login(mobile, context);
                        },
                        child: Text(
                          'Resend OTP',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: AppFontSize.s16,
                            fontWeight: AppFontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: AppDimensions.height3),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
