import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:grpc_bloc_example/src/route/navigation_cubit.dart';
import 'package:grpc_bloc_example/src/route/navigation_stack.dart';
import 'package:grpc_bloc_example/src/route/page_config.dart';
import 'package:grpc_bloc_example/src/splash/splash.dart';

void main() {
  group('NavigationCubit', () {
    test('initial state', () {
      final loginBloc = NavigationCubit([PageConfig(location: "/login")]);
      expect(loginBloc.state.length,
          NavigationStack([PageConfig(location: "/login")]).length);
    });

    test('initial state  page', () {
      final loginBloc = NavigationCubit([PageConfig(location: "/splash")]);
      expect(loginBloc.state.pages.first is SplashPage, true);
    });
  });
}
