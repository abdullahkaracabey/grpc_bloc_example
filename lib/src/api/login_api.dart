import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:grpc_bloc_example/src/api/base_api.dart';
import 'package:grpc_bloc_example/src/generated/poi.pbgrpc.dart';
import 'package:grpc_bloc_example/src/models/app_error.dart';

class LoginApi extends BaseApi {
  Future<String?> login(String username, String password) async {
    try {
      var stub = AuthenticationClient(channel);

      var response = await stub
          .login(LoginRequest(username: username, password: password));

      var token = response.token;

      return token;
    } on GrpcError catch (e) {
      debugPrint("error $e");

      throw AppException(message: e.message ?? "", code: e.code);
    }
  }
}
