import 'dart:async';

import 'package:grpc_bloc_example/src/api/login_api.dart';
import 'package:grpc_bloc_example/src/repositories/base_repository.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository implements BaseRepository {
  final controller = StreamController<AuthenticationStatus>();
  String? _token;

  Stream<AuthenticationStatus> get status async* {
    if (_token != null && _token!.isNotEmpty) {
      yield AuthenticationStatus.unauthenticated;
    } else {
      yield AuthenticationStatus.unauthenticated;
    }
    yield* controller.stream;
  }

  String? get token => _token;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    _token = await LoginApi().login(username, password);

    if (_token != null && _token!.isNotEmpty) {
      controller.add(AuthenticationStatus.authenticated);
    }
  }

  void logout() {
    controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => controller.close();
}
