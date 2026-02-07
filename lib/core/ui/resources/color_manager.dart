import 'package:flutter/material.dart';

abstract class ColorManager {
  static const Color colorPrimary = Color(0xff1D3557);
  static const Color colorSecondary = Color(0xff457B9D);
  static const Color colorThird = Color(0xffA8DADC);

  static const Color colorBlue200 = Color(0xFF7BA1B9);

  static const Color colorBackground = Color(0xffffffff);
  static const Color colorDarkBackground = Color(0xffEFEFEF);

  static const Color colorFontPrimary = Color(0xFF202020);
  static const Color colorFontSecondary = Color(0xFF747474);

  static const Color colorSuccess = Color(0xFF4caf50);

  static Color colorTextFieldFill = Color(0xFFfcfcfc);
  static Color colorTextFieldEnabledBorder = Color(0xffe5e7eb).withValues(alpha: 0.9);
  static Color colorTextFieldFocusedBorder = Color(0xffe5e7eb).withValues(alpha: 0.9);
  static Color colorTextFieldErrorBorder = const Color(0xFFe23a31);

  static const Color colorGrey0 = Color(0xFFEAEAEA);
  static const Color colorGrey1 = Color(0xFFE1E1E1);
  static const Color colorGrey2 = Color(0xFF969696);
  static const Color colorGrey3 = Color(0xFF474747);
  static const Color colorError = Color(0xffe23a31);
  static const Color colorRed = Color(0xffff4a41);
  static const Color colorWhite = Color(0xffFFFFFF);
  static const Color colorBlack = Color(0xff202020);
  static const Color colorGreen = Color(0xff53a062);
  static const Color colorSpin = Color(0xFFFFFFFF);
  static const Color colorOrange = Color(0xFFFFAE00);
  static const Color colorOrange2 = Color(0xFFFF9900);

  static Color shimmerBaseColor = Colors.grey.shade300;
  static Color shimmerHighlightColor = Colors.grey.shade100;
}
