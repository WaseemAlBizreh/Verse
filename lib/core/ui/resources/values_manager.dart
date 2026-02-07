import 'package:flutter/material.dart';

import '../../../main.dart';

abstract class AppSize {
  static double get s1 => _AdaptiveSize.getSize(1);

  static double get s1_5 => _AdaptiveSize.getSize(1.5);

  static double get s2 => _AdaptiveSize.getSize(2);

  static double get s4 => _AdaptiveSize.getSize(4);

  static double get s6 => _AdaptiveSize.getSize(6);

  static double get s8 => _AdaptiveSize.getSize(8);

  static double get s9 => _AdaptiveSize.getSize(9);

  static double get s10 => _AdaptiveSize.getSize(10);

  static double get s12 => _AdaptiveSize.getSize(12);

  static double get s14 => _AdaptiveSize.getSize(14);

  static double get s16 => _AdaptiveSize.getSize(16);

  static double get s18 => _AdaptiveSize.getSize(18);

  static double get s20 => _AdaptiveSize.getSize(20);

  static double get s22 => _AdaptiveSize.getSize(22);

  static double get s24 => _AdaptiveSize.getSize(24);

  static double get s26 => _AdaptiveSize.getSize(26);

  static double get s28 => _AdaptiveSize.getSize(28);

  static double get s30 => _AdaptiveSize.getSize(30);

  static double get s32 => _AdaptiveSize.getSize(32);

  static double get s34 => _AdaptiveSize.getSize(34);

  static double get s36 => _AdaptiveSize.getSize(36);

  static double get s40 => _AdaptiveSize.getSize(40);

  static double get s45 => _AdaptiveSize.getSize(45);

  static double get s50 => _AdaptiveSize.getSize(50);

  static double get s55 => _AdaptiveSize.getSize(55);

  static double get s60 => _AdaptiveSize.getSize(60);

  static double get s65 => _AdaptiveSize.getSize(65);

  // Screen dimensions
  static double get sWidth => MediaQuery.sizeOf(MyApp.appContext!).width;

  static double get sHeight => MediaQuery.sizeOf(MyApp.appContext!).height;
}

class _AdaptiveSize {
  static double getSize(double baseSize) {
    double screenWidth = MediaQuery.sizeOf(MyApp.appContext!).width;
    const double baseScreenWidth = 375.0;

    double scaleFactor = screenWidth / baseScreenWidth;

    // Apply constraints to prevent extreme scaling
    scaleFactor = scaleFactor.clamp(0.8, 1.4);

    return baseSize * scaleFactor;
  }
}
