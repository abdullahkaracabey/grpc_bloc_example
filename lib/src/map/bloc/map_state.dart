part of 'map_bloc.dart';

class MapState extends Equatable {
  const MapState._({this.locations});

  const MapState.empty() : this._();

  const MapState.locationsChanged(List<PoiReply>? list)
      : this._(locations: list);

  final List<PoiReply>? locations;

  @override
  List<Object> get props => [if (locations != null) locations!];
}
