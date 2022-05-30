import 'package:flutter/material.dart';
import 'package:grpc_bloc_example/src/app.dart';
import 'package:grpc_bloc_example/src/repositories/authentication_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");

  runApp(const App());
}
