import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_bloc_example/src/route/navigation_stack.dart';
import 'package:grpc_bloc_example/src/route/page_config.dart';

class NavigationCubit extends Cubit<NavigationStack> {
  NavigationCubit(List<PageConfig> initialPages)
      : super(NavigationStack(initialPages));

  void push(String path, [Map<String, dynamic>? args]) {
    print('push called with $path and $args');
    PageConfig config = PageConfig(location: path, args: args);
    emit(state.push(config));
    // FirebaseAnalytics.instance.logScreenView(screenName: path);
  }

  void clearAndPush(String path, [Map<String, dynamic>? args]) {
    PageConfig config = PageConfig(location: path, args: args);
    emit(state.clearAndPush(config));
    // FirebaseAnalytics.instance.logScreenView(screenName: path);
  }

  void pop() {
    emit(state.pop());
  }

  bool canPop() {
    return state.canPop();
  }

  void pushBeneathCurrent(String path, [Map<String, dynamic>? args]) {
    final PageConfig config = PageConfig(location: path, args: args);
    emit(state.pushBeneathCurrent(config));
    // FirebaseAnalytics.instance.logScreenView(screenName: path);
  }
}
