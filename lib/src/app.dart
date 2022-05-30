import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_bloc_example/src/app_state/app_state.dart';
import 'package:grpc_bloc_example/src/authentication/bloc/authentication_bloc.dart';
import 'package:grpc_bloc_example/src/favorites/bloc/favorites_bloc.dart';
import 'package:grpc_bloc_example/src/map/bloc/map_bloc.dart';
import 'package:grpc_bloc_example/src/login/login.dart';
import 'package:grpc_bloc_example/src/repositories/app_state_repository.dart';
import 'package:grpc_bloc_example/src/repositories/map_repository.dart';
import 'package:grpc_bloc_example/src/route/navigation_cubit.dart';
import 'package:grpc_bloc_example/src/route/page_config.dart';
import 'package:grpc_bloc_example/src/route/router_delegate.dart';
import 'package:grpc_bloc_example/src/util/app_theme_data.dart';

import 'repositories/authentication_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppStateRepository>(
          create: (context) => AppStateRepository(),
        ),
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => AuthenticationRepository(),
        ),
        RepositoryProvider<MapRepository>(
          create: (context) => MapRepository(
              authenticationRepository:
                  RepositoryProvider.of<AuthenticationRepository>(context)),
        )
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider<NavigationCubit>(
            create: (_) => NavigationCubit([
                  PageConfig(location: "/splash"),
                  // PageConfig(location: "/login")
                ])),
        BlocProvider(
            create: (context) => AppStateBloc(
                appStateRepository:
                    RepositoryProvider.of<AppStateRepository>(context))),
        BlocProvider(
            create: (context) => AuthenticationBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context))),
        BlocProvider(
            create: (context) => LoginBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context))),
        BlocProvider(
            create: (context) => MapBloc(
                mapRepository: RepositoryProvider.of<MapRepository>(context))),
        BlocProvider(create: (context) => FavoritesBloc())
      ], child: AppView()),
    );
    // return RepositoryProvider.value(
    //   value: authenticationRepository,
    //   child: BlocProvider(
    //     create: (_) => AuthenticationBloc(
    //       authenticationRepository: authenticationRepository,
    //       // userRepository: userRepository,
    //     ),
    //     child: AppView(),
    //   ),
    // );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      // localizationsDelegates: const [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      //   GlobalCupertinoLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en', ''),
      //   Locale('de', ''),
      //   Locale('tr', ''),
      // ],
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      themeMode: ThemeMode.light,
      home: Router(
        routerDelegate:
            ERouterDelegate(BlocProvider.of<NavigationCubit>(context)),
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
