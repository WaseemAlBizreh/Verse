import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:verse/core/ui/resources/font_manager.dart';

import '../../../../../core/ui/resources/breakpoints.dart';
import '../../../../../core/ui/resources/color_manager.dart';
import '../../../../../core/ui/resources/values_manager.dart';
import '../../../../../core/ui/widgets/app_button.dart';
import '../../../../../core/ui/widgets/custom_cached_image.dart';
import '../../../models/slider_model.dart';

/// Web-only slider carousel: full-width slides, 16:9 height, content overlay, dots below.
/// Use on large screens; mobile keeps using [SliderCarouselWidget].
class WebSliderCarouselWidget extends StatelessWidget {
  const WebSliderCarouselWidget({
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
    final height = context.height16x9.clamp(
      MediaQuery.sizeOf(context).height * 0.5,
      MediaQuery.sizeOf(context).height * 0.75,
    );

    if (sliders.isEmpty) {
      return Container(
        height: height,
        decoration: BoxDecoration(
          color: ColorManager.colorPrimary,
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppSize.s12),
      child: SizedBox(
        height: height,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CarouselSlider.builder(
              itemCount: sliders.length,
              itemBuilder: (context, index, realIndex) {
                final slider = sliders[index];
                return _WebSliderSlide(
                  slider: slider,
                  height: height,
                );
              },
              options: CarouselOptions(
                height: height,
                initialPage: currentIndex.clamp(0, sliders.length - 1),
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
                onPageChanged: onPageChanged,
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: AppSize.s24,
              child: _WebCarouselIndicators(
                count: sliders.length,
                currentIndex: currentIndex,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WebSliderSlide extends StatelessWidget {
  const _WebSliderSlide({
    required this.slider,
    required this.height,
  });

  final SliderModel slider;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CustomCachedNetworkImage(
          imageUrl: slider.imageUrl,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          borderRadius: 0,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                ColorManager.colorPrimary.withValues(alpha: 0.92),
                ColorManager.colorPrimary.withValues(alpha: 0.5),
                Colors.transparent,
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(48, AppSize.s24, 48, AppSize.s45),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppSize.s12,
                        vertical: AppSize.s6,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.colorGrey2.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(AppSize.s8),
                      ),
                      child: Text(
                        'movies'.tr(),
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: ColorManager.colorFontPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                    SizedBox(height: AppSize.s16),
                    Text(
                      slider.title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: ColorManager.colorFontPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: FontSize.s24,
                          ),
                    ),
                    SizedBox(height: AppSize.s12),
                    Text(
                      slider.description,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: ColorManager.colorFontPrimary.withValues(
                              alpha: 0.9,
                            ),
                          ),
                    ),
                    SizedBox(height: AppSize.s24),
                    SizedBox(
                      width: AppSize.sWidth * 0.2  ,
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
            ],
          ),
        ),
      ],
    );
  }
}

class _WebCarouselIndicators extends StatelessWidget {
  const _WebCarouselIndicators({
    required this.count,
    required this.currentIndex,
  });

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = currentIndex == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive
                ? ColorManager.colorThird
                : ColorManager.colorGrey2.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
