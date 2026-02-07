import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/ui/resources/breakpoints.dart';
import '../../../../core/ui/resources/color_manager.dart';
import '../../../../core/ui/resources/values_manager.dart';

class SliderShimmerWidget extends StatelessWidget {
  const SliderShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final sliderHeight = context.height16x9.clamp(
      AppSize.sHeight * 0.22,
      AppSize.sHeight * 0.45,
    );

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.s16,
        vertical: AppSize.s16,
      ),
      child: Shimmer.fromColors(
        baseColor: ColorManager.shimmerBaseColor,
        highlightColor: ColorManager.shimmerHighlightColor,
        child: Column(
          children: [
            Container(
              height: sliderHeight,
              margin: EdgeInsets.only(bottom: AppSize.s24),
              decoration: BoxDecoration(
                color: ColorManager.colorGrey1,
                borderRadius: BorderRadius.circular(AppSize.s12),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: AppSize.s8,
                  height: AppSize.s8,
                  decoration: BoxDecoration(
                    color: ColorManager.colorGrey1,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: AppSize.s8),
                Container(
                  width: AppSize.s8,
                  height: AppSize.s8,
                  decoration: BoxDecoration(
                    color: ColorManager.colorGrey1,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
