import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc_bloc_example/src/api/poi_api.dart';
import 'package:grpc_bloc_example/src/generated/poi.pb.dart';
import 'package:grpc_bloc_example/src/repositories/authentication_repository.dart';
import 'package:grpc_bloc_example/src/repositories/base_repository.dart';

class MapRepository implements BaseRepository {
  final _controller = StreamController<List<PoiReply>?>();
  final AuthenticationRepository authenticationRepository;
  late ResponseStream<PoiReply> _poiStream;
  List<PoiReply>? _poiLocations;

  MapRepository({
    required this.authenticationRepository,
  });
  Stream<List<PoiReply>?> get poiLocations async* {
    yield _poiLocations;

    yield* _controller.stream;
  }

  void fetchPoiLocations() {
    debugPrint("Poi location started to fetch");
    _poiStream = PoiApi().poiLocations(authenticationRepository.token!);

    _poiStream.listen((value) {
      debugPrint("new poi location ${value.name}");
      _poiLocations ??= <PoiReply>[];
      _poiLocations!.add(value);

      _controller.add(_poiLocations);
    });
  }

  void dispose() {
    _controller.close();
    _poiStream.cancel();
  }
}
