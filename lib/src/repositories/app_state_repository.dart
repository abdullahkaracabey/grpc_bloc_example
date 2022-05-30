import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:grpc_bloc_example/firebase_options.dart';
import 'package:grpc_bloc_example/src/models/app_error.dart';
import 'package:grpc_bloc_example/src/repositories/base_repository.dart';

enum AppStateStatus { unknown, error, initialized }

class AppStateRepository implements BaseRepository {
  final _controller = StreamController<AppStateStatus>();

  FirebaseApp? _firebaseApp;
  AppException? error;
  AppStateRepository() {
    _init();
  }

  Future<void> _init() async {
    debugPrint("Firebase initialization triggered");
    try {
      // throw AppException(message: "Error ....");
      _firebaseApp = await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      _controller.add(AppStateStatus.initialized);
      debugPrint("Firebase initialization completed");
    } catch (e) {
      _controller.add(AppStateStatus.error);

      //todo handle possible errors -> connection and firebase error codes
      error = AppException(message: e.toString());
      debugPrint("Firebase initialization has error, ${error?.message}");
    }
  }

  bool get isAppInitialized => _firebaseApp != null;
  Stream<AppStateStatus> get status async* {
    if (_firebaseApp != null) {
      yield AppStateStatus.initialized;
    } else if (error != null) {
      yield AppStateStatus.error;
    } else {
      yield AppStateStatus.unknown;
    }
    yield* _controller.stream;
  }

  void dispose() => _controller.close();
}
