import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grpc_bloc_example/src/repositories/app_state_repository.dart';
import 'package:grpc_bloc_example/src/repositories/authentication_repository.dart';

part 'app_state_event.dart';
part 'app_state_state.dart';

class AppStateBloc extends Bloc<AppStateEvent, AppStateState> {
  AppStateBloc({
    required AppStateRepository appStateRepository,
  })  : _appStateRepository = appStateRepository,
        super(const AppStateState.unknown()) {
    on<AppStateStatusChanged>(_onAppStateStatusChanged);

    _appStateSubscription = _appStateRepository.status.listen(
      (status) => add(AppStateStatusChanged(status)),
    );
  }

  final AppStateRepository _appStateRepository;
  late StreamSubscription<AppStateStatus> _appStateSubscription;

  @override
  Future<void> close() {
    _appStateSubscription.cancel();
    _appStateRepository.dispose();
    return super.close();
  }

  void _onAppStateStatusChanged(
    AppStateStatusChanged event,
    Emitter<AppStateState> emit,
  ) async {
    switch (event.status) {
      case AppStateStatus.error:
        return emit(const AppStateState.error());
      case AppStateStatus.initialized:
        return emit(const AppStateState.initialized());
      default:
        return emit(const AppStateState.unknown());
    }
  }
}
