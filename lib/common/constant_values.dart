import 'package:gandhi_tvs/common/app_imports.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }

  static double fontSize(double factor) => screenHeight * factor;
  static double width(double factor) => screenWidth * factor;
  static double height(double factor) => screenHeight * factor;
}

class AppFontSize {
  static double get s10 => SizeConfig.fontSize(0.010);
  static double get s12 => SizeConfig.fontSize(0.012);
  static double get s14 => SizeConfig.fontSize(0.014);
  static double get s16 => SizeConfig.fontSize(0.016);
  static double get s18 => SizeConfig.fontSize(0.018);
  static double get s20 => SizeConfig.fontSize(0.020);
  static double get s22 => SizeConfig.fontSize(0.022);
  static double get s24 => SizeConfig.fontSize(0.024);
  static double get s26 => SizeConfig.fontSize(0.026);
  static double get s28 => SizeConfig.fontSize(0.028);
  static double get s34 => SizeConfig.fontSize(0.034);
  static double get s42 => SizeConfig.fontSize(0.042);
}

class AppFontWeight {
  static const FontWeight w100 = FontWeight.w100;
  static const FontWeight w200 = FontWeight.w200;
  static const FontWeight w300 = FontWeight.w300;
  static const FontWeight w400 = FontWeight.w400;
  static const FontWeight w500 = FontWeight.w500;
  static const FontWeight w600 = FontWeight.w600;
  static const FontWeight w700 = FontWeight.w700;
  static const FontWeight w800 = FontWeight.w800;
  static const FontWeight w900 = FontWeight.w900;
  static const FontWeight bold = FontWeight.bold;
}

class AppColors {
  static const Color primary = Color(0xFF0D47A1);
  static const Color secondary = Color(0xFF1976D2);
  static const Color accent = Color(0xFFFFC107);
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color themeColor = Color(0xFFdc4226);
  static const Color warning = Color(0xFFFF9800);
  static const Color disabled = Color(0xFFBDBDBD);
  static const Color divider = Color(0xFFBDBDBD);
}

class AppDimensions {
  static double get width1 => SizeConfig.width(0.01);
  static double get width2 => SizeConfig.width(0.02);
  static double get width3 => SizeConfig.width(0.03);
  static double get width5 => SizeConfig.width(0.05);
  static double get width8 => SizeConfig.width(0.08);
  static double get width10 => SizeConfig.width(0.10);
  static double get width20 => SizeConfig.width(0.20);
  static double get width25 => SizeConfig.width(0.25);
  static double get width30 => SizeConfig.width(0.30);
  static double get width40 => SizeConfig.width(0.40);
  static double get width50 => SizeConfig.width(0.50);
  static double get width80 => SizeConfig.width(0.80);
  static double get fullWidth => SizeConfig.screenWidth;

  static double get height1 => SizeConfig.height(0.01);
  static double get height2 => SizeConfig.height(0.02);
  static double get height3 => SizeConfig.height(0.03);
  static double get height4 => SizeConfig.height(0.04);
  static double get height5 => SizeConfig.height(0.05);
  static double get height6 => SizeConfig.height(0.06);
  static double get height8 => SizeConfig.height(0.08);
  static double get height10 => SizeConfig.height(0.10);
  static double get height15 => SizeConfig.height(0.15);
  static double get height16 => SizeConfig.height(0.16);
  static double get height20 => SizeConfig.height(0.20);
  static double get height30 => SizeConfig.height(0.30);
  static double get height40 => SizeConfig.height(0.40);
  static double get height50 => SizeConfig.height(0.50);
  static double get height60 => SizeConfig.height(0.60);
  static double get height70 => SizeConfig.height(0.70);
  static double get height80 => SizeConfig.height(0.80);
  static double get height90 => SizeConfig.height(0.90);
  static double get fullHeight => SizeConfig.screenHeight;
}

class AppPadding {
  static EdgeInsets get p0 => EdgeInsets.all(SizeConfig.width(0.0));
  static EdgeInsets get p1 => EdgeInsets.all(SizeConfig.width(0.01));
  static EdgeInsets get p2 => EdgeInsets.all(SizeConfig.width(0.02));
  static EdgeInsets get p4 => EdgeInsets.all(SizeConfig.width(0.04));
  static EdgeInsets get p6 => EdgeInsets.all(SizeConfig.width(0.06));
  static EdgeInsets get p8 => EdgeInsets.all(SizeConfig.width(0.08));
  static EdgeInsets get p16 => EdgeInsets.all(SizeConfig.width(0.16));
}

class AppMargin {
  static EdgeInsets get m0 => EdgeInsets.all(SizeConfig.width(0.0));
  static EdgeInsets get m1 => EdgeInsets.all(SizeConfig.width(0.01));
  static EdgeInsets get m2 => EdgeInsets.all(SizeConfig.width(0.02));
  static EdgeInsets get m4 => EdgeInsets.all(SizeConfig.width(0.04));
  static EdgeInsets get m6 => EdgeInsets.all(SizeConfig.width(0.06));
  static EdgeInsets get m8 => EdgeInsets.all(SizeConfig.width(0.08));
}

class AppBorderRadius {
  static BorderRadius get r0 => BorderRadius.circular(0);
  static BorderRadius get r1 => BorderRadius.circular(SizeConfig.width(0.01));
  static BorderRadius get r2 => BorderRadius.circular(SizeConfig.width(0.02));
  static BorderRadius get r4 => BorderRadius.circular(SizeConfig.width(0.04));
  static BorderRadius get r8 => BorderRadius.circular(SizeConfig.width(0.08));
}

class AppIconSize {
  static double get iS3 => SizeConfig.width(0.03);
  static double get iS4 => SizeConfig.width(0.04);
  static double get iS6 => SizeConfig.width(0.06);
  static double get iS8 => SizeConfig.width(0.08);
  static double get iS12 => SizeConfig.width(0.12);
}

class AppDurations {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 600);
}
