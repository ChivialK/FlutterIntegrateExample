// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;

import 'empty_page.dart' as _i4;
import 'main.dart' as _i3;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    MyHomeRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (data) {
          final args = data.argsAs<MyHomeRouteArgs>(
              orElse: () => const MyHomeRouteArgs());
          return _i3.MyHomePage(key: args.key);
        }),
    EmptyRoute.name: (routeData) => _i1.MaterialPageX<dynamic>(
        routeData: routeData,
        builder: (_) {
          return _i4.EmptyPage();
        })
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(MyHomeRoute.name, path: '/'),
        _i1.RouteConfig(EmptyRoute.name, path: '/empty-page')
      ];
}

class MyHomeRoute extends _i1.PageRouteInfo<MyHomeRouteArgs> {
  MyHomeRoute({_i2.Key? key})
      : super(name, path: '/', args: MyHomeRouteArgs(key: key));

  static const String name = 'MyHomeRoute';
}

class MyHomeRouteArgs {
  const MyHomeRouteArgs({this.key});

  final _i2.Key? key;
}

class EmptyRoute extends _i1.PageRouteInfo {
  const EmptyRoute() : super(name, path: '/empty-page');

  static const String name = 'EmptyRoute';
}
