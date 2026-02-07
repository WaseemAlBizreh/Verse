import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/values_manager.dart';

class CarouselSliderWidget<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final double? height;
  final double viewportFraction;
  final double enlargeFactor;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final bool enlargeCenterPage;
  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;
  final int currentIndex;
  final bool showIndicators;
  final int? maxIndicatorCount;

  const CarouselSliderWidget({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.height,
    this.viewportFraction = 0.8,
    this.enlargeFactor = 0.2,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 10),
    this.enlargeCenterPage = true,
    this.onPageChanged,
    this.currentIndex = 0,
    this.showIndicators = true,
    this.maxIndicatorCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: items.length,
          itemBuilder: (context, index, realIndex) {
            return itemBuilder(context, items[index], index);
          },
          options: CarouselOptions(
            height: height,
            enlargeCenterPage: enlargeCenterPage,
            viewportFraction: viewportFraction,
            enlargeFactor: enlargeFactor,
            autoPlay: autoPlay,
            autoPlayInterval: autoPlayInterval,
            onPageChanged: onPageChanged,
          ),
        ),
        if (showIndicators && items.isNotEmpty) ...[
          SizedBox(height: AppSize.s10),
          _buildIndicators(),
        ],
      ],
    );
  }

  Widget _buildIndicators() {
    final itemsLength = items.length;
    final displayCount = maxIndicatorCount ?? (itemsLength == 2 ? 2 : 3);
    final actualDisplayCount = itemsLength < displayCount
        ? itemsLength
        : displayCount;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(actualDisplayCount, (index) {
        int visibleIndex = itemsLength > actualDisplayCount
            ? currentIndex % actualDisplayCount
            : currentIndex % actualDisplayCount;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          margin: EdgeInsets.symmetric(horizontal: AppSize.s2),
          width: index == visibleIndex ? AppSize.s18 : AppSize.s8,
          height: AppSize.s8,
          decoration: BoxDecoration(
            color: visibleIndex == index
                ? ColorManager.colorPrimary
                : ColorManager.colorGrey2,
            borderRadius: BorderRadius.circular(AppSize.s10),
          ),
        );
      }),
    );
  }
}
