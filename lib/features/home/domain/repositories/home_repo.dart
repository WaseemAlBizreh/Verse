import '../../../../core/models/user_model.dart';
import '../../../../core/utils/types.dart';

abstract class HomeRepo {
  FutureEither<UserModel> getProfile();
}
