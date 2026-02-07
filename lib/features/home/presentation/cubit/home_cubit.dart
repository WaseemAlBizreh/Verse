import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/models/enums/loading_state_enum.dart';
import '../../domain/repositories/home_repo.dart';
import '../../models/movie_model.dart';
import '../../models/slider_model.dart';

part 'home_state.dart';

@lazySingleton
class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repo) : super(const HomeState());

  final HomeRepo _repo;

  /// Call this on refresh to load both sliders and movies (each uses its own loading state).
  Future<void> getHomeData() async {
    await Future.wait([getSliders(), getMovies()]);
  }

  Future<void> getSliders() async {
    if (state.slidersLoadingState == LoadingState.loading) return;

    emit(state.copyWith(
      slidersLoadingState: LoadingState.loading,
      slidersErrorMessage: null,
    ));

    final result = await _repo.getSliders();

    result.fold(
      (error) => emit(state.copyWith(
        slidersLoadingState: LoadingState.hasError,
        slidersErrorMessage: error.toString(),
      )),
      (sliders) => emit(state.copyWith(
        slidersLoadingState: sliders.isEmpty
            ? LoadingState.doneWithNoData
            : LoadingState.doneWithData,
        sliders: sliders,
        slidersErrorMessage: null,
      )),
    );
  }

  Future<void> getMovies() async {
    if (state.moviesLoadingState == LoadingState.loading) return;

    emit(state.copyWith(
      moviesLoadingState: LoadingState.loading,
      moviesErrorMessage: null,
    ));

    final result = await _repo.getMovies();

    result.fold(
      (error) => emit(state.copyWith(
        moviesLoadingState: LoadingState.hasError,
        moviesErrorMessage: error.toString(),
      )),
      (movies) => emit(state.copyWith(
        moviesLoadingState: movies.isEmpty
            ? LoadingState.doneWithNoData
            : LoadingState.doneWithData,
        movies: movies,
        moviesErrorMessage: null,
      )),
    );
  }

  void onSliderPageChanged(int index) {
    emit(state.copyWith(currentSliderIndex: index));
  }

  void logout() {}
}
