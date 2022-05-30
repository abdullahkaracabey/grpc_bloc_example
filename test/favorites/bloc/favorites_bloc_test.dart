// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:bloc_test/bloc_test.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:grpc_bloc_example/src/favorites/bloc/favorites_bloc.dart';
import 'package:grpc_bloc_example/src/generated/poi.pb.dart';

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

  group('FavoritesBloc', () {
    test('initial state is FavoritesState', () {
      final loginBloc = FavoritesBloc();
      expect(loginBloc.state, const FavoritesState.empty());
    });

    group('FavoritesBloc with empty list', () {
      blocTest<FavoritesBloc, FavoritesState>(
        'emit list',
        setUp: () {
          // when(
          //   () => mapRepository.poiLocations,
          // ).thenAnswer((_) => Stream.value(locations));
        },
        build: () => FavoritesBloc(),
        act: (bloc) {
          bloc.add(const FavoritesChanged([]));
        },
        expect: () => [FavoritesState.empty()],
      );
    });
    group('FavoritesBloc with  list', () {
      blocTest<FavoritesBloc, FavoritesState>(
        'emit list',
        setUp: () {
          // when(
          //   () => mapRepository.poiLocations,
          // ).thenAnswer((_) => Stream.value(locations));
        },
        build: () => FavoritesBloc(),
        act: (bloc) {
          bloc.add(FavoritesChanged(locations));
        },
        // ignore: prefer_const_constructors
        expect: () => [FavoritesState.favoritesChanged(locations)],
      );
    });
    group('FavoritesBloc with  list', () {
      blocTest<FavoritesBloc, FavoritesState>(
        'emit list',
        setUp: () {
          // when(
          //   () => mapRepository.poiLocations,
          // ).thenAnswer((_) => Stream.value(locations));
        },
        build: () => FavoritesBloc(),
        act: (bloc) {
          bloc.add(FavoritesChanged(locations));
          bloc.add(FavoritesChanged([]));
        },
        // ignore: prefer_const_constructors
        expect: () => [
          FavoritesState.favoritesChanged(locations),
          FavoritesState.empty()
        ],
      );
    });
    group('FavoritesBloc with  list', () {
      blocTest<FavoritesBloc, FavoritesState>(
        'emit list',
        setUp: () {
          // when(
          //   () => mapRepository.poiLocations,
          // ).thenAnswer((_) => Stream.value(locations));
        },
        build: () => FavoritesBloc(),
        act: (bloc) {
          bloc.addOrRemoveFromFavorites(locations.first);
          bloc.addOrRemoveFromFavorites(locations.first);
        },
        // ignore: prefer_const_constructors
        expect: () => [
          FavoritesState.favoritesChanged(locations),
          FavoritesState.empty(),
        ],
      );
    });
  });
}
