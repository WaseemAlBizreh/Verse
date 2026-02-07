import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/asset_manger.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';
import 'custom_cached_image.dart';

class ImageUploadBox extends StatelessWidget {
  const ImageUploadBox({
    super.key,
    required this.title,
    this.imagePath,
    this.onTap,
    this.onRemove,
  });

  final String title;
  final String? imagePath;
  final void Function()? onTap;
  final void Function()? onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImage = imagePath != null && imagePath!.isNotEmpty;
    final isUrl = hasImage && imagePath!.startsWith('http');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: ColorManager.colorFontPrimary,
          ),
        ),
        SizedBox(height: AppSize.s10),
        Container(
          height: AppSize.sHeight * 0.2,
          width: double.infinity,
          decoration: BoxDecoration(
            color: ColorManager.colorWhite,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: ColorManager.colorTextFieldEnabledBorder,
              width: 2,
            ),
          ),
          padding: EdgeInsets.all(AppSize.s6),
          child: hasImage
              ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: isUrl
                          ? CustomCachedNetworkImage(
                              imageUrl: imagePath!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              File(imagePath!),
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                    ),
                    if (onRemove != null)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: InkWell(
                          onTap: onRemove,
                          child: Container(
                            decoration: BoxDecoration(
                              color: ColorManager.colorGrey1,
                              borderRadius: BorderRadius.circular(AppSize.s6),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: AppSize.s4,
                              vertical: AppSize.s4,
                            ),
                            child: SvgPicture.asset(
                              IconsAssets.cancelIcon,
                              width: AppSize.s18,
                            ),
                          ),
                        ),
                      ),
                  ],
                )
              : InkWell(
                  onTap: onTap,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        IconsAssets.cameraIcon,
                        width: AppSize.s34,
                      ),
                      SizedBox(height: AppSize.s10),
                      Text(
                        'upload_image'.tr(),
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }
}

