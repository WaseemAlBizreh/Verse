import 'package:flutter/material.dart';

/// Breakpoints for responsive layouts. Tuned for 16:9 screens (e.g. Android TV, web).
abstract class Breakpoints {
  Breakpoints._();

  /// Small: phone portrait
  static const double small = 600;

  /// Medium: tablet / large phone
  static const double medium = 900;

  /// Large: web desktop, small TV (e.g. 720p 16:9 width ~1280)
  static const double large = 1280;

  /// Extra large: wide web, Android TV 1080p (16:9 width 1920)
  static const double extraLarge = 1920;

  /// 16:9 aspect ratio (width / height)
  static const double aspectRatio16x9 = 16 / 9;

  /// Returns height for a 16:9 area given [width].
  static double height16x9(double width) => width / aspectRatio16x9;
}

extension BreakpointContextExtension on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// True when width >= [Breakpoints.medium] (e.g. tablet / web layout).
  bool get isMediumOrLarger => screenWidth >= Breakpoints.medium;

  /// True when width >= [Breakpoints.large] (e.g. desktop / TV).
  bool get isLargeScreen => screenWidth >= Breakpoints.large;

  /// True when width >= [Breakpoints.extraLarge] (e.g. 1080p TV).
  bool get isExtraLargeScreen => screenWidth >= Breakpoints.extraLarge;

  /// Aspect ratio of the current view (width / height).
  double get aspectRatio => screenWidth / screenHeight;

  /// True when layout is roughly 16:9 or wider (e.g. TV, landscape).
  bool get isWideScreen16x9 => aspectRatio >= Breakpoints.aspectRatio16x9 - 0.15;

  /// Height for a 16:9 band given current width.
  double get height16x9 => Breakpoints.height16x9(screenWidth);
}
