import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/ui/resources/breakpoints.dart';
import '../../../../../core/ui/resources/color_manager.dart';
import '../../../../../core/ui/resources/values_manager.dart';

/// Web-only shimmer for hero banner area.
class WebHeroShimmerWidget extends StatelessWidget {
  const WebHeroShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final height = context.height16x9.clamp(
      MediaQuery.sizeOf(context).height * 0.5,
      MediaQuery.sizeOf(context).height * 0.75,
    );

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSize.s16),
      child: Shimmer.fromColors(
        baseColor: ColorManager.shimmerBaseColor,
        highlightColor: ColorManager.shimmerHighlightColor,
        child: Container(
          height: height,
          decoration: BoxDecoration(
            color: ColorManager.colorGrey1,
            borderRadius: BorderRadius.circular(AppSize.s12),
          ),
        ),
      ),
    );
  }
}
