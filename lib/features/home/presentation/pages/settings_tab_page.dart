import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/resources/color_manager.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Settings',
        style: TextStyle(
          fontSize: 18,
          color: ColorManager.colorFontPrimary,
        ),
      ),
    );
  }
}
