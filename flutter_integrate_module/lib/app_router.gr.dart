// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import 'empty_page.dart' as _i2;
import 'main.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    MyHomeRoute.name: (routeData) {
      final args = routeData.argsAs<MyHomeRouteArgs>(
          orElse: () => const MyHomeRouteArgs());
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: _i1.MyHomePage(key: args.key));
    },
    EmptyRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.EmptyPage());
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(MyHomeRoute.name, path: '/'),
        _i3.RouteConfig(EmptyRoute.name, path: '/empty-page')
      ];
}

/// generated route for
/// [_i1.MyHomePage]
class MyHomeRoute extends _i3.PageRouteInfo<MyHomeRouteArgs> {
  MyHomeRoute({_i4.Key? key})
      : super(MyHomeRoute.name, path: '/', args: MyHomeRouteArgs(key: key));

  static const String name = 'MyHomeRoute';
}

class MyHomeRouteArgs {
  const MyHomeRouteArgs({this.key});

  final _i4.Key? key;

  @override
  String toString() {
    return 'MyHomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.EmptyPage]
class EmptyRoute extends _i3.PageRouteInfo<void> {
  const EmptyRoute() : super(EmptyRoute.name, path: '/empty-page');

  static const String name = 'EmptyRoute';
}
