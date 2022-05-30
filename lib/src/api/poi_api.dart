import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc_bloc_example/src/api/base_api.dart';
import 'package:grpc_bloc_example/src/generated/poi.pbgrpc.dart';
import 'package:grpc_bloc_example/src/models/app_error.dart';

class PoiApi extends BaseApi {
  ResponseStream<PoiReply> poiLocations(String token) {
    try {
      var stub = PoiLocatorClient(channel);

      var response = stub.getPois(
        PoiRequest(),
        options: CallOptions(metadata: {
          'Authorization': 'Bearer $token',
        }),
      );

      return response;
    } on GrpcError catch (e) {
      debugPrint("error $e");

      throw AppException(message: e.message ?? "", code: e.code);
    }
  }
}
