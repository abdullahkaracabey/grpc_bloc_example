part of 'app_state_bloc.dart';

abstract class AppStateEvent extends Equatable {
  const AppStateEvent();

  @override
  List<Object> get props => [];
}

class AppStateStatusChanged extends AppStateEvent {
  const AppStateStatusChanged(this.status);

  final AppStateStatus status;

  @override
  List<Object> get props => [status];
}
