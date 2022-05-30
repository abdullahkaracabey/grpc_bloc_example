import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:grpc_bloc_example/src/generated/poi.pb.dart';
import 'package:grpc_bloc_example/src/map/bloc/map_bloc.dart';
import 'package:grpc_bloc_example/src/repositories/map_repository.dart';

class MockMapRepository extends Mock implements MapRepository {}

void main() {
  late MapRepository mapRepository;

  var locations = [
    PoiReply(
        lat: 39.944289,
        lon: 32.858186,
        name: "Augustus Tapınağı",
        openNow: true,
        website:
            "https://turkishmuseums.com/museum/detail/1946-ankara-augustus-tapinagi/1946/1")
  ];

  setUp(() {
    mapRepository = MockMapRepository();
    when(
      () => mapRepository.poiLocations,
    ).thenAnswer((_) => Stream.value([]));
  });

  group('MapBloc', () {
    test('initial state is MapState', () {
      final loginBloc = MapBloc(
        mapRepository: mapRepository,
      );
      expect(loginBloc.state, const MapState.empty());
    });

    group('MapBloc with list', () {
      blocTest<MapBloc, MapState>(
        'emit list',
        setUp: () {
          when(
            () => mapRepository.poiLocations,
          ).thenAnswer((_) => Stream.value(locations));
        },
        build: () => MapBloc(
          mapRepository: mapRepository,
        ),
        // act: (bloc) {
        //   bloc.add(LocationsChanged(locations));
        // },
        expect: () => <MapState>[MapState.locationsChanged(locations)],
      );
    });
  });
}
