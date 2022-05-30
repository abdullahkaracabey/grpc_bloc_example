// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:grpc_bloc_example/src/generated/poi.pb.dart';
import 'package:grpc_bloc_example/src/map/bloc/map_bloc.dart';

void main() {
  var locations = [
    PoiReply(
        lat: 39.944289,
        lon: 32.858186,
        name: "Augustus Tapınağı",
        openNow: true,
        website:
            "https://turkishmuseums.com/museum/detail/1946-ankara-augustus-tapinagi/1946/1")
  ];
  group('MapEvent', () {
    test('supports value comparisons', () {
      expect(LocationsChanged(const <PoiReply>[]),
          LocationsChanged(const <PoiReply>[]));
    });
    test('supports value comparisons', () {
      expect(LocationsChanged(locations), LocationsChanged(locations));
    });
  });
}
