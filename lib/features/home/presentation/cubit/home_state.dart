part of 'home_cubit.dart';

class HomeState {
  const HomeState({
    this.slidersLoadingState = LoadingState.idle,
    this.moviesLoadingState = LoadingState.idle,
    this.sliders = const [],
    this.movies = const [],
    this.currentSliderIndex = 0,
    this.slidersErrorMessage,
    this.moviesErrorMessage,
  });

  final LoadingState slidersLoadingState;
  final LoadingState moviesLoadingState;
  final List<SliderModel> sliders;
  final List<MovieModel> movies;
  final int currentSliderIndex;
  final String? slidersErrorMessage;
  final String? moviesErrorMessage;

  HomeState copyWith({
    LoadingState? slidersLoadingState,
    LoadingState? moviesLoadingState,
    List<SliderModel>? sliders,
    List<MovieModel>? movies,
    int? currentSliderIndex,
    String? slidersErrorMessage,
    String? moviesErrorMessage,
  }) {
    return HomeState(
      slidersLoadingState: slidersLoadingState ?? this.slidersLoadingState,
      moviesLoadingState: moviesLoadingState ?? this.moviesLoadingState,
      sliders: sliders ?? this.sliders,
      movies: movies ?? this.movies,
      currentSliderIndex: currentSliderIndex ?? this.currentSliderIndex,
      slidersErrorMessage: slidersErrorMessage ?? this.slidersErrorMessage,
      moviesErrorMessage: moviesErrorMessage ?? this.moviesErrorMessage,
    );
  }
}
