library devfest_server;

import 'dart:io';
import 'package:logging/logging.dart';
import 'package:rpc/rpc.dart';
import 'package:devfest_dart_code_lab/server/api.dart';

final ApiServer apiServer = new ApiServer(prettyPrint: true);

main() async {
  Logger.root..level = Level.INFO..onRecord.listen(print);

  apiServer.addApi(new DevFestApi());
  HttpServer server = await HttpServer.bind(InternetAddress.ANY_IP_V4, 8080);
  server.listen(apiServer.httpRequestHandler);
  print('Server listening on http://${server.address.host}: ${server.port}');
}