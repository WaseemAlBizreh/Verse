import 'package:flutter/material.dart';

extension BuildContextTextThemeX on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
