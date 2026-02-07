import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/config/injection.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/services/cache_service.dart';
import '../../../../core/utils/types.dart';
import '../../domain/repositories/home_repo.dart';
import '../data_source/home_remote_ds.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDS remoteDS = locator<HomeRemoteDS>();

  @override
  FutureEither<UserModel> getProfile() async {
    final response = await remoteDS.getProfile();
    return response.fold((error) => Left(error), (user) async {
      await locator<CacheService>().updateUserInfo(user);
      return Right(user);
    });
  }
}
