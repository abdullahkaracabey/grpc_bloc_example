// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:grpc_bloc_example/src/map/bloc/map_bloc.dart';

void main() {
  group('MapState', () {
    test('supports value comparisons', () {
      expect(MapState.empty(), MapState.empty());
    });
  });
}
