import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../main.dart';
import '../extensions/context_extensions.dart';
import '../resources/asset_manger.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/values_manager.dart';

enum CustomToastType { success, error, warning }

enum CustomToastPosition { bottom, center }

class CustomToasts {
  const CustomToasts({
    required this.message,
    required this.type,
    this.details,
    this.duration,
    this.position = CustomToastPosition.bottom,
  });

  final String message;
  final CustomToastType type;
  final String? details;
  final Duration? duration;
  final CustomToastPosition position;

  void show() {
    final context = MyApp.appContext;
    if (context == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? const Duration(seconds: 3),
        backgroundColor: ColorManager.colorWhite,
        elevation: 2,
        dismissDirection: DismissDirection.horizontal,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.only(
          bottom:
          MediaQuery.of(context).viewInsets.bottom +
              (position == CustomToastPosition.center
                  ? AppSize.sHeight * 0.4
                  : AppSize.s30),
          left: AppSize.s14,
          right: AppSize.s14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s8),
        ),
        behavior: SnackBarBehavior.floating,
        content: Container(
          padding: EdgeInsets.all(AppSize.s8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: AppSize.sWidth * 0.1,
                    child: Builder(
                      builder: (context) {
                        switch (type) {
                          case CustomToastType.success:
                            return SvgPicture.asset(
                              IconsAssets.checkCircleIcon,
                              colorFilter: ColorFilter.mode(
                                ColorManager.colorSuccess,
                                BlendMode.srcIn,
                              ),
                            );
                          case CustomToastType.warning:
                            return SvgPicture.asset(
                              IconsAssets.alertCircleIcon,
                              colorFilter: ColorFilter.mode(
                                ColorManager.colorOrange,
                                BlendMode.srcIn,
                              ),
                            );
                          case CustomToastType.error:
                            return SvgPicture.asset(
                              IconsAssets.xCircleIcon,
                              colorFilter: ColorFilter.mode(
                                ColorManager.colorError,
                                BlendMode.srcIn,
                              ),
                            );
                        }
                      },
                    ),
                  ),
                  SizedBox(width: AppSize.s8),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: AppSize.sWidth * 0.55,
                        child: Text(
                          message,
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall!.copyWith(
                            color: ColorManager.colorFontPrimary,
                            fontSize: FontSize.s13,
                          ),
                        ),
                      ),
                      details == null
                          ? Container()
                          : SizedBox(
                        width: AppSize.sWidth * 0.55,
                        child: Text(
                          details!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall!,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
