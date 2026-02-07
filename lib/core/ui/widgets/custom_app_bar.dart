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
  final bool showNotification;
  final List<Widget> actions;

  const CustomAppBar({
    super.key,
    this.title,
    this.onBack,
    this.actions = const [],
    this.showBackButton = false,
    this.showNotification = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.colorPrimary,
      surfaceTintColor: ColorManager.colorPrimary,
      elevation: 0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      leadingWidth: showBackButton || showNotification
          ? AppSize.sWidth * 0.15
          : AppSize.sWidth * 0.23,
      leading: showBackButton
          ? IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: ColorManager.colorWhite,
                size: AppSize.s20,
              ),
              onPressed: onBack ?? () => context.pop(),
            )
          : showNotification
          ? InkWell(
              borderRadius: BorderRadius.circular(555),
              splashColor: ColorManager.colorPrimary,
              onTap: () {
                // context.router.push(const NotificationsRoute());
              },
              child: Padding(
                padding: EdgeInsets.all(AppSize.s14),
                child: SvgPicture.asset(
                  IconsAssets.notificationIcon,
                  colorFilter: ColorFilter.mode(
                    ColorManager.colorWhite,
                    BlendMode.srcIn,
                  ),
                  width: AppSize.s22,
                  height: AppSize.s22,
                ),
              ),
            )
          : SizedBox(),
      title: title,
      titleSpacing: AppSize.s4,
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppSize.s50);
}
