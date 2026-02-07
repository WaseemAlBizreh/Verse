import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/ui/resources/color_manager.dart';

@RoutePage()
class SeriesPage extends StatelessWidget {
  const SeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'series'.tr(),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: ColorManager.colorFontPrimary,
            ),
      ),
    );
  }
}
