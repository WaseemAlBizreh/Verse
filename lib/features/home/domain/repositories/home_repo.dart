import '../../../../core/utils/types.dart';
import '../../models/movie_model.dart';
import '../../models/slider_model.dart';

abstract class HomeRepo {
  FutureEither<List<SliderModel>> getSliders();
  FutureEither<List<MovieModel>> getMovies();
}
