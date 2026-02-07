import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'router.gr.dart';

final navigationKey = GlobalKey<NavigatorState>();

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter(GlobalKey<NavigatorState> navigatorKey)
      : super(navigatorKey: navigatorKey);

  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
      ];
}
