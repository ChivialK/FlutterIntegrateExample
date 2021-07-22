import 'package:auto_route/auto_route.dart';

import 'empty_page.dart';
import 'main.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: MyHomePage, initial: true),
    AutoRoute(page: EmptyPage),
  ],
)
class $AppRouter {}
