import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/ui/resources/color_manager.dart';
import '../../../../core/ui/resources/values_manager.dart';

class TopMoviesShimmerWidget extends StatelessWidget {
  const TopMoviesShimmerWidget({super.key});

  static double get _cardWidth => AppSize.sWidth * 0.82;
  static double get _cardHeight => AppSize.sHeight * 0.2;

  @override
  Widget build(BuildContext context) {
    const int itemCount = 4;

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
              width: AppSize.sWidth * 0.4,
              height: AppSize.s24,
              decoration: BoxDecoration(
                color: ColorManager.colorGrey1,
                borderRadius: BorderRadius.circular(AppSize.s6),
              ),
            ),
          ),
          SizedBox(
            height: _cardHeight + AppSize.s12,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: AppSize.s16),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: itemCount,
              separatorBuilder: (_, __) => SizedBox(width: AppSize.s12),
              itemBuilder: (_, __) => SizedBox(
                width: _cardWidth,
                child: _ShimmerCard(
                  width: _cardWidth,
                  height: _cardHeight,
                ),
              ),
            ),
          ),
          SizedBox(height: AppSize.s24),
        ],
      ),
    );
  }
}

class _ShimmerCard extends StatelessWidget {
  const _ShimmerCard({
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    final posterWidth = height * 0.65;

    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.symmetric(vertical: AppSize.s6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: posterWidth,
            decoration: BoxDecoration(
              color: ColorManager.colorGrey1,
              borderRadius: BorderRadius.circular(AppSize.s10),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(AppSize.s12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: AppSize.s40,
                        height: AppSize.s20,
                        decoration: BoxDecoration(
                          color: ColorManager.colorGrey1,
                          borderRadius: BorderRadius.circular(AppSize.s6),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: AppSize.s22,
                        height: AppSize.s22,
                        decoration: BoxDecoration(
                          color: ColorManager.colorGrey1,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
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
                  SizedBox(height: AppSize.s8),
                  Container(
                    width: AppSize.s60,
                    height: AppSize.s14,
                    decoration: BoxDecoration(
                      color: ColorManager.colorGrey1,
                      borderRadius: BorderRadius.circular(AppSize.s4),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: AppSize.s36,
                    height: AppSize.s14,
                    decoration: BoxDecoration(
                      color: ColorManager.colorGrey1,
                      borderRadius: BorderRadius.circular(AppSize.s4),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
