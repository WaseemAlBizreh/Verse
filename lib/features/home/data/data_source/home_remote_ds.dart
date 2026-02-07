import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/config/injection.dart';
import '../../../../core/models/enums/http_method.dart';
import '../../../../core/services/network_service/api_service.dart';
import '../../../../core/services/network_service/end_points.dart';
import '../../../../core/utils/types.dart';
import '../../models/movie_model.dart';
import '../../models/slider_model.dart';

abstract class HomeRemoteDS {
  FutureEither<List<SliderModel>> getSliders();
  FutureEither<List<MovieModel>> getMovies();
}

@LazySingleton(as: HomeRemoteDS)
class HomeRemoteDsImpl implements HomeRemoteDS {
  @override
  FutureEither<List<SliderModel>> getSliders() async {
    final response = await locator<ApiService>().request(
      url: Api.sliders,
      method: Method.get,
      requiredToken: false,
    );

    return response.fold(
      (error) => Left(error),
      (response) {
        final data = response.data;
        if (data is List) {
          final list = data
              .map((e) => SliderModel.fromJson(e as Map<String, dynamic>))
              .toList();
          return Right(list);
        }
        return Right([]);
      },
    );
  }

  @override
  FutureEither<List<MovieModel>> getMovies() async {
    final response = await locator<ApiService>().request(
      url: Api.movies,
      method: Method.get,
      requiredToken: false,
    );

    return response.fold(
      (error) => Left(error),
      (response) {
        final data = response.data;
        if (data is List) {
          final list = data
              .map((e) => MovieModel.fromJson(e as Map<String, dynamic>))
              .toList();
          return Right(list);
        }
        return Right([]);
      },
    );
  }
}
