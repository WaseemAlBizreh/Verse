import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:verse/core/config/injection.dart';
import 'package:verse/features/home/presentation/cubit/home_cubit.dart';

import '../extensions/context_extensions.dart';
import '../resources/asset_manger.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/values_manager.dart';
import 'app_button.dart';

class LogoutDialog {
  static Future<void> show(BuildContext context) async {
    if (!context.mounted) return;

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => BlocProvider.value(
        value: locator<HomeCubit>(),
        child: _LogoutDialogWidget(),
      ),
    );
  }
}

class _LogoutDialogWidget extends StatelessWidget {
  const _LogoutDialogWidget();

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: AppSize.s20),
      child: Container(
        width: AppSize.sWidth * 0.95,
        constraints: BoxConstraints(maxHeight: AppSize.sHeight * 0.8),
        decoration: BoxDecoration(
          color: ColorManager.colorWhite,
          borderRadius: BorderRadius.circular(AppSize.s16),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppSize.s16,
          vertical: AppSize.s16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Icon(
                  Icons.close_rounded,
                  color: ColorManager.colorBlack,
                  size: AppSize.s24,
                ),
              ),
            ),
            SizedBox(height: AppSize.s10),
            SvgPicture.asset(
              IconsAssets.logoutIcon,
              width: AppSize.sWidth * 0.23,
              height: AppSize.sWidth * 0.23,
              colorFilter: ColorFilter.mode(
                ColorManager.colorError,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: AppSize.s20),
            Text(
              'logout'.tr(),
              textAlign: TextAlign.center,
              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: AppSize.s4),
            Text(
              'logout_message'.tr(),
              textAlign: TextAlign.center,
              style: textTheme.bodySmall?.copyWith(
                color: ColorManager.colorFontSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: AppSize.s24),
            Row(
              spacing: AppSize.s10,
              children: [
                Expanded(
                  child: AppButton(
                    text: 'cancel'.tr(),
                    backgroundColor: ColorManager.colorGrey1,
                    fontColor: ColorManager.colorBlack,
                    fontWeight: FontWeight.w600,
                    fontSize: FontSize.s14,
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return Expanded(
                      child: AppButton(
                        text: 'logout'.tr(),
                        backgroundColor: ColorManager.colorError,
                        fontColor: ColorManager.colorWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: FontSize.s14,
                        onPressed: () async {
                          context.pop();
                          context.read<HomeCubit>().logout();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
