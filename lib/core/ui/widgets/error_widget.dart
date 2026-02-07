import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../extensions/context_extensions.dart';
import '../resources/asset_manger.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import 'app_button.dart';

class ErrorAppWidget extends StatelessWidget {
  final String? title;
  final bool isInternetError;
  final String? subtitle;
  final double? width;
  final double? height;
  final VoidCallback? onRetry;
  final String? buttonText;

  const ErrorAppWidget({
    super.key,
    this.title,
    required this.isInternetError,
    this.subtitle,
    this.width,
    this.height,
    this.onRetry,
    this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          isInternetError
              ? IconsAssets.noConnectionIcon
              : IconsAssets.alertCircleIcon,
          width: width ?? AppSize.sWidth * 0.25,
          height: height ?? AppSize.sWidth * 0.25,
          colorFilter: ColorFilter.mode(
            isInternetError ? ColorManager.colorGrey1 : ColorManager.colorError,
            BlendMode.srcIn,
          ),
          fit: BoxFit.contain,
        ),
        SizedBox(height: AppSize.s30),
        Text(
          title ??
              (!isInternetError
                  ? 'error_something_wrong'.tr()
                  : 'error_check_connection'.tr()),
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
            color: ColorManager.colorFontPrimary,
          ),
        ),
        if (subtitle != null && subtitle!.isNotEmpty) ...[
          SizedBox(height: AppSize.s12),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: context.textTheme.titleSmall!.copyWith(
              color: ColorManager.colorFontSecondary,
              height: 1.3,
            ),
          ),
        ],
        if (onRetry != null) ...[
          SizedBox(height: AppSize.s30),
          SizedBox(
            width: AppSize.sWidth * 0.3,
            child: AppButton(
              minHeight: 20,
              padding: EdgeInsets.zero,
              text: buttonText ?? 'retry'.tr(),
              onPressed: onRetry,
              backgroundColor: ColorManager.colorPrimary,
              fontColor: ColorManager.colorFontPrimary,
            ),
          ),
        ],
      ],
    );
  }
}
