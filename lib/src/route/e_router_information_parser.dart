import 'package:flutter/material.dart';
import 'package:grpc_bloc_example/src/route/page_config.dart';

class AppRouteInformationParser extends RouteInformationParser<PageConfig> {
  ///get a location (path) from the system and build your route wrapping object
  @override
  Future<PageConfig> parseRouteInformation(
      RouteInformation routeInformation) async {
    final String path = routeInformation.location ?? '';
    PageConfig config = PageConfig(location: path);
    return config;
  }

  ///update the URL bar with the latest URL from the app
  @override
  RouteInformation? restoreRouteInformation(PageConfig configuration) {
    return RouteInformation(location: configuration.path.toString());
  }
}
