import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:grpc_bloc_example/src/route/app_page.dart';

class NotFoundPage extends AppPage {
  NotFoundPage() : super(args: {});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Not found"),
    );
  }
}
