import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class BaseApi {
  final channel = ClientChannel(
    dotenv.env['apiUrl']!,
    port: int.parse(dotenv.env['port']!),
    options: const ChannelOptions(
      credentials: ChannelCredentials.insecure(),
      // connectionTimeout: Duration(seconds: 3)
    ),
  );

  // final channel = ClientChannel(
  //   Platform.isAndroid ? "10.0.2.2" : "127.0.0.1",
  //   port: 50051,
  //   options: const ChannelOptions(
  //       credentials: ChannelCredentials.insecure(),
  //       connectionTimeout: Duration(seconds: 10)),
  // );
}
