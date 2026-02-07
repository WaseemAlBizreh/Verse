import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/asset_manger.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;
  final Widget? title;
  final bool showBackButton;
  final List<Widget> actions;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onSearchPressed;

  const CustomAppBar({
    super.key,
    this.title,
    this.onBack,
    this.actions = const [],
    this.showBackButton = false,
    this.onNotificationPressed,
    this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.colorSecondary,
      surfaceTintColor: ColorManager.colorSecondary,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      leadingWidth: showBackButton
          ? AppSize.sWidth * 0.15
          : AppSize.sWidth * 0.3,
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: ColorManager.colorWhite,
                size: AppSize.s20,
              ),
              onPressed: onBack ?? () => context.pop(),
            )
          : Padding(
              padding: EdgeInsets.all(AppSize.s6),
              child: Image.asset(ImageAssets.logoImage),
            ),
      title: title,
      titleSpacing: AppSize.s4,
      centerTitle: false,
      actions: [
        ...actions,
        if (onSearchPressed != null) ...[
          Container(
            width: AppSize.s40,
            height: AppSize.s40,
            padding: EdgeInsets.all(AppSize.s8),
            child: SvgPicture.asset(
              IconsAssets.searchIcon,
              colorFilter: const ColorFilter.mode(
                ColorManager.colorWhite,
                BlendMode.srcIn,
              ),
              width: AppSize.s22,
              height: AppSize.s22,
            ),
          ),
          SizedBox(width: AppSize.s8),
        ],
        if (onNotificationPressed != null)
          Container(
            width: AppSize.s40,
            height: AppSize.s40,
            padding: EdgeInsets.all(AppSize.s8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSize.s16),
              color: ColorManager.colorAppBarIconCircle,
            ),
            child: SvgPicture.asset(
              IconsAssets.notificationIcon,
              colorFilter: const ColorFilter.mode(
                ColorManager.colorWhite,
                BlendMode.srcIn,
              ),
              width: AppSize.s22,
              height: AppSize.s22,
            ),
          ),
        SizedBox(width: AppSize.s20),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppSize.s50);
}
