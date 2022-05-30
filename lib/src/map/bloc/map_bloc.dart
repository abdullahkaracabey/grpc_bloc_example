import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:grpc_bloc_example/src/generated/poi.pb.dart';

import 'package:grpc_bloc_example/src/repositories/map_repository.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc({
    required MapRepository mapRepository,
  })  : _mapRepository = mapRepository,
        super(const MapState.empty()) {
    on<LocationsChanged>(_onLocationsChanged);
    _mapRepository.fetchPoiLocations();

    _poiLocationsSubscription = _mapRepository.poiLocations.listen(
      (locations) => add(LocationsChanged(locations)),
    );
  }

  final MapRepository _mapRepository;
  // final UserRepository _userRepository;
  late StreamSubscription<List<PoiReply>?> _poiLocationsSubscription;

  @override
  Future<void> close() {
    _poiLocationsSubscription.cancel();
    _mapRepository.dispose();
    return super.close();
  }

  void _onLocationsChanged(
    LocationsChanged event,
    Emitter<MapState> emit,
  ) async {
    emit(MapState.locationsChanged(event.list));
  }

  void onOpenLocation(PoiReply location) {
    FirebaseAnalytics.instance.logEvent(
        name: "LocationOpened", parameters: {"locationName": location.name});
  }
}
