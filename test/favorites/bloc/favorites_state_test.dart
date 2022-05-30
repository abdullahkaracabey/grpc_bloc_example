// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:grpc_bloc_example/src/favorites/bloc/favorites_bloc.dart';
import 'package:grpc_bloc_example/src/map/bloc/map_bloc.dart';

void main() {
  group('FavoritesState', () {
    test('supports value comparisons', () {
      expect(FavoritesState.empty(), FavoritesState.empty());
    });
  });
}
