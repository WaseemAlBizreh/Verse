import 'package:injectable/injectable.dart';

import '../../../../core/config/injection.dart';
import '../../../../core/utils/types.dart';
import '../../domain/repositories/home_repo.dart';
import '../../models/movie_model.dart';
import '../../models/slider_model.dart';
import '../data_source/home_remote_ds.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDS remoteDS = locator<HomeRemoteDS>();

  @override
  FutureEither<List<SliderModel>> getSliders() async {
    return remoteDS.getSliders();
  }

  @override
  FutureEither<List<MovieModel>> getMovies() async {
    return remoteDS.getMovies();
  }
}
