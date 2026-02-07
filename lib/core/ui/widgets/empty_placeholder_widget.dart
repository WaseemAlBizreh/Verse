import 'package:flutter/material.dart';

import '../extensions/context_extensions.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';


class EmptyPlaceholderWidget extends StatelessWidget {
  const EmptyPlaceholderWidget({
    super.key,
    required this.imagePath,
    required this.title,
    this.subtitle,
    this.width,
    this.height,
  });

  final String imagePath;
  final String title;
  final String? subtitle;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imagePath,
          width: width ?? AppSize.sWidth * 0.4,
          height: height ?? AppSize.sWidth * 0.4,
          fit: BoxFit.contain,
        ),
        SizedBox(height: AppSize.s16),
        Text(
          title,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: ColorManager.colorFontPrimary,
          ),
        ),
        if (subtitle != null && subtitle!.isNotEmpty) ...[
          SizedBox(height: AppSize.s10),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: context.textTheme.titleSmall?.copyWith(
              color: ColorManager.colorFontSecondary,
              height: 1.3,
            ),
          ),
        ],
      ],
    );
  }
}

