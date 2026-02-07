import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/resources/color_manager.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorManager.colorPrimary),
      child: Text('Home'),
    );
  }
}
