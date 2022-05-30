import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:grpc_bloc_example/src/route/app_page.dart';

class SplashPage extends AppPage {
  const SplashPage(Map<String, dynamic> args) : super(args: args);


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
