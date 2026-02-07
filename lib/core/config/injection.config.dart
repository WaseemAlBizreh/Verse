// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/home/data/data_source/home_remote_ds.dart' as _i379;
import '../../features/home/data/repositories/home_repo_imp.dart' as _i359;
import '../../features/home/domain/repositories/home_repo.dart' as _i1021;
import '../../features/home/presentation/cubit/home_cubit.dart' as _i9;
import '../../features/home/presentation/cubit/root_cubit.dart' as _i148;
import '../services/cache_service.dart' as _i717;
import '../services/network_service/api_service.dart' as _i623;
import '../services/permission_service.dart' as _i165;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  gh.singleton<_i717.CacheService>(() => _i717.CacheService());
  gh.singleton<_i623.ApiService>(() => _i623.ApiService());
  gh.singleton<_i165.PermissionService>(() => _i165.PermissionService());
  gh.singleton<_i148.RootCubit>(() => _i148.RootCubit());
  gh.lazySingleton<_i9.HomeCubit>(() => _i9.HomeCubit());
  gh.lazySingleton<_i379.HomeRemoteDS>(() => _i379.HomeRemoteDsImpl());
  gh.lazySingleton<_i1021.HomeRepo>(() => _i359.HomeRepoImpl());
  return getIt;
}
