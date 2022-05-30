import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grpc_bloc_example/src/favorites/bloc/favorites_bloc.dart';
import 'package:grpc_bloc_example/src/favorites/view/favorites_screen.dart';
import 'package:grpc_bloc_example/src/generated/poi.pb.dart';
import 'package:grpc_bloc_example/src/route/app_page.dart';

class FavoritesPage extends AppPage {
  const FavoritesPage(Map<String, dynamic> args) : super(args: args);

  @override
  Widget build(BuildContext context) {
    return FavoritesScreen();
  }
}
