// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:verse/features/home/presentation/pages/home_page.dart' as _i1;
import 'package:verse/features/home/presentation/pages/live_tab_page.dart'
    as _i2;
import 'package:verse/features/home/presentation/pages/movies_tab_page.dart'
    as _i3;
import 'package:verse/features/home/presentation/pages/root_page.dart' as _i4;
import 'package:verse/features/home/presentation/pages/series_tab_page.dart'
    as _i5;
import 'package:verse/features/home/presentation/pages/settings_tab_page.dart'
    as _i6;

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomePage();
    },
  );
}

/// generated route for
/// [_i2.LivePage]
class LiveRoute extends _i7.PageRouteInfo<void> {
  const LiveRoute({List<_i7.PageRouteInfo>? children})
    : super(LiveRoute.name, initialChildren: children);

  static const String name = 'LiveRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.LivePage();
    },
  );
}

/// generated route for
/// [_i3.MoviesPage]
class MoviesRoute extends _i7.PageRouteInfo<void> {
  const MoviesRoute({List<_i7.PageRouteInfo>? children})
    : super(MoviesRoute.name, initialChildren: children);

  static const String name = 'MoviesRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.MoviesPage();
    },
  );
}

/// generated route for
/// [_i4.RootPage]
class RootRoute extends _i7.PageRouteInfo<void> {
  const RootRoute({List<_i7.PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.RootPage();
    },
  );
}

/// generated route for
/// [_i5.SeriesPage]
class SeriesRoute extends _i7.PageRouteInfo<void> {
  const SeriesRoute({List<_i7.PageRouteInfo>? children})
    : super(SeriesRoute.name, initialChildren: children);

  static const String name = 'SeriesRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.SeriesPage();
    },
  );
}

/// generated route for
/// [_i6.SettingsPage]
class SettingsRoute extends _i7.PageRouteInfo<void> {
  const SettingsRoute({List<_i7.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.SettingsPage();
    },
  );
}
