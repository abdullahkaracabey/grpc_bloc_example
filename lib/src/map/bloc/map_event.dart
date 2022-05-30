part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();
}

class LocationsChanged extends MapEvent {
  const LocationsChanged(this.list);

  final List<PoiReply>? list;

  @override
  List<Object> get props => [if (list != null) list!];
}
