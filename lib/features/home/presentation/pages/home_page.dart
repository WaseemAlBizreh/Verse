import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:verse/core/ui/resources/values_manager.dart' show AppSize;

import '../../../../core/models/enums/loading_state_enum.dart';
import '../../../../core/ui/resources/color_manager.dart';
import '../cubit/home_cubit.dart';
import '../widgets/slider_carousel_widget.dart';
import '../widgets/slider_shimmer_widget.dart';
import '../widgets/top_movies_section_widget.dart';
import '../widgets/top_movies_shimmer_widget.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: AppSize.s20),
      decoration: const BoxDecoration(color: ColorManager.colorPrimary),
      child: RefreshIndicator(
        onRefresh: () => context.read<HomeCubit>().getHomeData(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.sizeOf(context).height - 100,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    switch (state.slidersLoadingState) {
                      case LoadingState.idle:
                      case LoadingState.loading:
                        return const SliderShimmerWidget();
                      case LoadingState.doneWithData:
                        return SliderCarouselWidget(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: ColorManager.colorError),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                    }
                  },
                ),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    switch (state.moviesLoadingState) {
                      case LoadingState.idle:
                      case LoadingState.loading:
                        return const TopMoviesShimmerWidget();
                      case LoadingState.doneWithData:
                        return TopMoviesSectionWidget(movies: state.movies);
                      case LoadingState.doneWithNoData:
                      case LoadingState.hasError:
                        return state.moviesLoadingState == LoadingState.hasError
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.all(AppSize.s16),
                                  child: Text(
                                    state.moviesErrorMessage ?? '',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: ColorManager.colorError),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
