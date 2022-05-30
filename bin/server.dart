// Copyright (c) 2018, the gRPC project authors. Please see the AUTHORS file
// for details. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// Dart implementation of the gRPC helloworld.Greeter server.
import 'package:grpc/grpc.dart';
import 'package:grpc_bloc_example/src/generated/poi.pbgrpc.dart';

class PoiService extends PoiLocatorServiceBase {
  @override
  Stream<PoiReply> getPois(ServiceCall call, PoiRequest request) async* {
    var list = [
      PoiReply(
          lat: 39.944289,
          lon: 32.858186,
          name: "Augustus Tapınağı",
          openNow: true,
          website:
              "https://turkishmuseums.com/museum/detail/1946-ankara-augustus-tapinagi/1946/1"),
      PoiReply(
          lat: 39.944331,
          lon: 32.85794,
          name: "Hacı Bayram-ı Velî Camii",
          openNow: true,
          website:
              "https://islamansiklopedisi.org.tr/haci-bayram-i-veli-kulliyesi"),
      PoiReply(
          lat: 39.941995,
          lon: 32.85376,
          name: "Kurtuluş Şavası Müzesi",
          openNow: true,
          website:
              "https://www.ktb.gov.tr/TR-96356/ankara---kurtulus-savasi-muzesi-i-tbmm-binasi.html")
    ];

    for (var feature in list) {
      yield feature;
    }
  }
}

class AuthService extends AuthenticationServiceBase {
  @override
  Future<LoginReply> login(ServiceCall call, LoginRequest request) async {
    String? token;
    if (request.username.toLowerCase() == "test" &&
        request.password == "Togg") {
      token = "asdasdasd";
    } else {
      throw GrpcError.invalidArgument("Password or username is not match");
    }

    return LoginReply(token: token);
  }
}

Future<void> main(List<String> args) async {
  final server = Server(
    [AuthService(), PoiService()],
    const <Interceptor>[],
    CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
  );
  await server.serve(port: 50051);
  print('Server listening on port ${server.port}...');
}
