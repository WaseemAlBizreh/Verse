import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/models/enums/loading_state_enum.dart';
import '../../../../../core/ui/resources/color_manager.dart';
import '../../../../../core/ui/resources/values_manager.dart';
import '../../cubit/home_cubit.dart';
import 'web_hero_banner_widget.dart';
import 'web_hero_shimmer_widget.dart';
import 'web_top_movies_list_widget.dart';
import 'web_top_movies_shimmer_widget.dart';

/// Web-only home layout: hero banner (left ~70%) + top movies list (right ~30%).
/// Use only when [context.isLargeScreen]; mobile keeps using original widgets.
class WebHomeContentWidget extends StatelessWidget {
  const WebHomeContentWidget({super.key});

  static const double _heroFlex = 7;
  static const double _listFlex = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: AppSize.s20),
      decoration: const BoxDecoration(color: ColorManager.colorPrimary),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: _heroFlex.toInt(),
                child: _buildHeroSection(context, state),
              ),
              SizedBox(width: AppSize.s16),
              Expanded(
                flex: _listFlex.toInt(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 400,
                    minWidth: 280,
                  ),
                  child: _buildTopMoviesSection(context, state),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context, HomeState state) {
    switch (state.slidersLoadingState) {
      case LoadingState.idle:
      case LoadingState.loading:
        return const WebHeroShimmerWidget();
      case LoadingState.doneWithData:
        return WebHeroBannerWidget(
          sliders: state.sliders,
          currentIndex: state.currentSliderIndex,
          onPageChanged: (index, _) =>
              context.read<HomeCubit>().onSliderPageChanged(index),
        );
      case LoadingState.doneWithNoData:
        return const SizedBox.shrink();
      case LoadingState.hasError:
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              state.slidersErrorMessage ?? '',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ColorManager.colorError,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        );
    }
  }

  Widget _buildTopMoviesSection(BuildContext context, HomeState state) {
    switch (state.moviesLoadingState) {
      case LoadingState.idle:
      case LoadingState.loading:
        return const WebTopMoviesShimmerWidget();
      case LoadingState.doneWithData:
        return WebTopMoviesListWidget(movies: state.movies);
      case LoadingState.doneWithNoData:
      case LoadingState.hasError:
        return state.moviesLoadingState == LoadingState.hasError
            ? Center(
                child: Padding(
                  padding: EdgeInsets.all(AppSize.s16),
                  child: Text(
                    state.moviesErrorMessage ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: ColorManager.colorError,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            : const SizedBox.shrink();
    }
  }
}
