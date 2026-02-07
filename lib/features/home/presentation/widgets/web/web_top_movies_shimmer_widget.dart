import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/ui/resources/color_manager.dart';
import '../../../../../core/ui/resources/values_manager.dart';

/// Web-only shimmer for top movies vertical list (right sidebar).
class WebTopMoviesShimmerWidget extends StatelessWidget {
  const WebTopMoviesShimmerWidget({super.key});

  static const double _posterWidth = 80;
  static const double _posterHeight = 120;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorManager.shimmerBaseColor,
      highlightColor: ColorManager.shimmerHighlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppSize.s16,
              AppSize.s20,
              AppSize.s16,
              AppSize.s12,
            ),
            child: Container(
              width: 120,
              height: AppSize.s24,
              decoration: BoxDecoration(
                color: ColorManager.colorGrey1,
                borderRadius: BorderRadius.circular(AppSize.s6),
              ),
            ),
          ),
          ...List.generate(4, (_) => _ShimmerTile()),
        ],
      ),
    );
  }
}

class _ShimmerTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.s16,
        vertical: AppSize.s8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: WebTopMoviesShimmerWidget._posterWidth,
            height: WebTopMoviesShimmerWidget._posterHeight,
            decoration: BoxDecoration(
              color: ColorManager.colorGrey1,
              borderRadius: BorderRadius.circular(AppSize.s8),
            ),
          ),
          SizedBox(width: AppSize.s12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: AppSize.s16,
                  decoration: BoxDecoration(
                    color: ColorManager.colorGrey1,
                    borderRadius: BorderRadius.circular(AppSize.s4),
                  ),
                ),
                SizedBox(height: AppSize.s8),
                Container(
                  width: double.infinity,
                  height: AppSize.s16,
                  decoration: BoxDecoration(
                    color: ColorManager.colorGrey1,
                    borderRadius: BorderRadius.circular(AppSize.s4),
                  ),
                ),
                SizedBox(height: AppSize.s6),
                Container(
                  width: 80,
                  height: AppSize.s12,
                  decoration: BoxDecoration(
                    color: ColorManager.colorGrey1,
                    borderRadius: BorderRadius.circular(AppSize.s4),
                  ),
                ),
                SizedBox(height: AppSize.s8),
                Container(
                  width: 40,
                  height: AppSize.s12,
                  decoration: BoxDecoration(
                    color: ColorManager.colorGrey1,
                    borderRadius: BorderRadius.circular(AppSize.s4),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
