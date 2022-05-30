import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_bloc_example/src/app_state/app_state.dart';
import 'package:grpc_bloc_example/src/authentication/authentication.dart';
import 'package:grpc_bloc_example/src/repositories/app_state_repository.dart';
import 'package:grpc_bloc_example/src/repositories/authentication_repository.dart';
import 'package:grpc_bloc_example/src/route/navigation_cubit.dart';
import 'package:grpc_bloc_example/src/route/navigation_stack.dart';
import 'package:grpc_bloc_example/src/route/page_config.dart';

///PopNavigatorRouterDelegateMixin wires android physical back button to its child Navigator
class ERouterDelegate extends RouterDelegate<PageConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfig> {
  final NavigationCubit _cubit;

  ERouterDelegate(this._cubit);

  @override
  Widget build(BuildContext context) {
    // return BlocConsumer<NavigationCubit, NavigationStack>(
    //   builder: (context, stack) {
    //     return Navigator(
    //       pages: stack.pages,
    //       key: navigatorKey,
    //       onPopPage: (route, result) => _onPopPage.call(route, result),
    //     );
    //   },
    //   listener: (context, stack) {
    //     debugPrint("consumer listener triggered");
    //   },
    // );

    return MultiBlocListener(
      listeners: [
        _listenForAppState(),
        _listenForAuth(),
      ],
      child: BlocConsumer<NavigationCubit, NavigationStack>(
        builder: (context, stack) {
          debugPrint("navigator build");
          return Navigator(
            pages: stack.pages,
            key: navigatorKey,
            onPopPage: (route, result) => _onPopPage.call(route, result),
          );
        },
        listener: (context, stack) {
          debugPrint("navigator listener");
        },
      ),
    );
  }

  ///here we handle back buttons
  bool _onPopPage(Route<dynamic> route, dynamic result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    if (_cubit.canPop()) {
      _cubit.pop();
      return true;
    } else {
      return false;
    }
  }

  BlocListener _listenForAppState() {
    return BlocListener<AppStateBloc, AppStateState>(
      listener: (context, state) {
        switch (state.status) {
          // case AppStateStatus.unknown:
          //   _cubit.push('/splash');

          //   break;
          case AppStateStatus.error:
            _cubit.push('/error');

            break;

          default:
        }
      },
    );
  }

  BlocListener _listenForAuth() {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) async {
        final appState = RepositoryProvider.of<AppStateRepository>(context);

        // if (!appState.isAppInitialized) return;

        if (state.status == AuthenticationStatus.authenticated) {
          ///navigate to the page the user wants or for the home page
          _cubit.clearAndPush('/home');
        }

        if (state.status != AuthenticationStatus.authenticated) {
          ///navigate to login/sign up/welcome page
          _cubit.clearAndPush('/login');
        }
      },
    );
  }

  @override
  Future<void> setNewRoutePath(PageConfig configuration) async {
    if (configuration.route != '/')
      _cubit.push(configuration.route, configuration.args);
  }

  ///called by router when it detects it may have changed because of a rebuild
  ///necessary for backward and forward buttons to work properly
  @override
  PageConfig? get currentConfiguration => _cubit.state.last;

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}
