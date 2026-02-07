import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../resources/asset_manger.dart';
import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final double? borderRadius;

  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width ?? AppSize.s60,
      height: height ?? AppSize.s60,
      fit: fit,
      placeholder: (context, url) =>
          placeholder ?? _DefaultPlaceholder(borderRadius ?? AppSize.s8),
      errorWidget: (context, url, error) => errorWidget ?? DefaultErrorWidget(),
      errorListener: (value) => log("$value"),
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? AppSize.s8),
          image: DecorationImage(image: imageProvider, fit: fit),
        ),
      ),
    );
  }
}

class _DefaultPlaceholder extends StatelessWidget {
  final double radius;

  const _DefaultPlaceholder(this.radius);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorManager.shimmerBaseColor,
      highlightColor: ColorManager.shimmerHighlightColor,
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.colorGrey1,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}

class DefaultErrorWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final double? borderRadius;

  const DefaultErrorWidget({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? AppSize.s60,
      width: width ?? AppSize.s60,
      padding: EdgeInsets.all(AppSize.s6),
      decoration: BoxDecoration(
        color: ColorManager.colorWhite,
        borderRadius: BorderRadius.circular(borderRadius ?? AppSize.s8),
      ),
      child: Image.asset(
        ImageAssets.placeholderImage,
        width: width,
        height: height,
      ),
    );
  }
}
