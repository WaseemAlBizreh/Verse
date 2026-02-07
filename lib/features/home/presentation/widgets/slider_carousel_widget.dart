import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:verse/core/ui/resources/font_manager.dart';

import '../../../../core/ui/resources/breakpoints.dart';
import '../../../../core/ui/resources/color_manager.dart';
import '../../../../core/ui/resources/values_manager.dart';
import '../../../../core/ui/widgets/app_button.dart';
import '../../../../core/ui/widgets/carousel_slider_widget.dart';
import '../../../../core/ui/widgets/custom_cached_image.dart';
import '../../models/slider_model.dart';

class SliderCarouselWidget extends StatelessWidget {
  const SliderCarouselWidget({
    super.key,
    required this.sliders,
    required this.currentIndex,
    required this.onPageChanged,
  });

  final List<SliderModel> sliders;
  final int currentIndex;
  final void Function(int index, dynamic reason) onPageChanged;

  @override
  Widget build(BuildContext context) {
    // 16:9 aspect ratio for TV / wide screens; cap by viewport height on narrow screens
    final sliderHeight = context.height16x9.clamp(
      AppSize.sHeight * 0.22,
      AppSize.sHeight * 0.45,
    );
    final viewportFraction = context.isLargeScreen ? 0.85 : 0.9;

    return CarouselSliderWidget<SliderModel>(
      items: sliders,
      height: sliderHeight,
      viewportFraction: viewportFraction,
      autoPlay: true,
      autoPlayInterval: const Duration(seconds: 5),
      currentIndex: currentIndex,
      onPageChanged: onPageChanged,
      activeIndicatorColor: ColorManager.colorThird,
      inactiveIndicatorColor: ColorManager.colorGrey2.withValues(alpha: 0.5),
      itemBuilder: (context, slider, index) {
        return _SliderCard(slider: slider, height: sliderHeight);
      },
    );
  }
}

class _SliderCard extends StatelessWidget {
  const _SliderCard({required this.slider, required this.height});

  final SliderModel slider;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: ColorManager.colorPrimary,
        borderRadius: BorderRadius.circular(AppSize.s20),
        border: Border.all(
          color: ColorManager.colorWhite.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomCachedNetworkImage(
              imageUrl: slider.imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              borderRadius: 0,
            ),
          ),
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    ColorManager.colorPrimary.withValues(alpha: 0.95),
                    ColorManager.colorPrimary.withValues(alpha: 0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppSize.s20),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        slider.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: ColorManager.colorFontPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.s18,
                        ),
                      ),
                      SizedBox(height: AppSize.s10),
                      Text(
                        slider.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorManager.colorFontPrimary.withValues(
                            alpha: 0.9,
                          ),
                        ),
                      ),
                      SizedBox(height: AppSize.s16),
                      SizedBox(
                        width: AppSize.sWidth * 0.32,
                        child: AppButton(
                          text: 'watch_now'.tr(),
                          fontSize: FontSize.s14,
                          backgroundColor: ColorManager.colorThird,
                          fontColor: ColorManager.colorGrey3,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
