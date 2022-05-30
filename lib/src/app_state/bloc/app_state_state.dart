part of 'app_state_bloc.dart';

class AppStateState extends Equatable {
  const AppStateState._({
    this.status = AppStateStatus.unknown,
  });

  const AppStateState.unknown() : this._();

  const AppStateState.initialized()
      : this._(status: AppStateStatus.initialized);

  const AppStateState.error() : this._(status: AppStateStatus.error);

  final AppStateStatus status;

  @override
  List<Object> get props => [status];
}
