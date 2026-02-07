import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/config/injection.dart';
import '../../../../core/models/enums/http_method.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/services/network_service/api_service.dart';
import '../../../../core/services/network_service/end_points.dart';
import '../../../../core/utils/types.dart';
abstract class HomeRemoteDS {
  FutureEither<UserModel> getProfile();
}

@LazySingleton(as: HomeRemoteDS)
class HomeRemoteDsImpl implements HomeRemoteDS {
  @override
  FutureEither<UserModel> getProfile() async {
    final response = await locator<ApiService>().request(
      url: Api.profileUrl,
      method: Method.get,
      requiredToken: true,
    );

    return response.fold(
      (error) => Left(error),
      (response) => Right(UserModel.fromJson(response.data ?? {})),
    );
  }
}
