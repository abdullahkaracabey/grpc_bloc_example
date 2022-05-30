import 'package:grpc_bloc_example/src/favorites/view/favorites_page.dart';
import 'package:grpc_bloc_example/src/login/login.dart';
import 'package:grpc_bloc_example/src/map/map.dart';
import 'package:grpc_bloc_example/src/route/page_config.dart';
import 'package:grpc_bloc_example/src/splash/splash.dart';
import 'package:grpc_bloc_example/src/views/screens/error_page.dart';
import 'package:grpc_bloc_example/src/views/screens/not_found_page.dart';

import 'app_page.dart';

AppPage getAppPage(PageConfig config) {
  print('looking for ${config.route}');
  AppPage p = _routes[config.route]?.call(config.args) ?? NotFoundPage();
  print('found $p');
  return p;
}

Map<String, AppPage Function(Map<String, dynamic>)> _routes = {
  '/splash': (args) => SplashPage(args),
  '/login': (args) => LoginPage(args),
  '/home': (args) => MapPage(args),
  '/error': (args) => ErrorPage(args),
  '/favorites': (args) => FavoritesPage(args),
};
