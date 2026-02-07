import 'package:flutter/material.dart';

import '../../../../../core/ui/resources/values_manager.dart';
import '../../../models/slider_model.dart';
import 'web_slider_carousel_widget.dart';

/// Web-only hero banner: wraps the web slider carousel with padding.
class WebHeroBannerWidget extends StatelessWidget {
  const WebHeroBannerWidget({
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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSize.s24),
      child: WebSliderCarouselWidget(
        sliders: sliders,
        currentIndex: currentIndex,
        onPageChanged: onPageChanged,
      ),
    );
  }
}
