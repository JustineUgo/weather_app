import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/src/screen/city_screen.dart';
import 'package:weather/src/screen/home_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  routes: <RouteBase>[
    GoRoute(
      path: RoutePath.home,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: RoutePath.city,
      builder: (BuildContext context, GoRouterState state) {
        return const CityScreen();
      },
    ),
  ],
);

class RoutePath {
  static const String home = '/';
  static const String city = '/city';
  
}
