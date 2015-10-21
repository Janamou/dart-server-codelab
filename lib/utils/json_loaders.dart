library json_loaders;

import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:devfest_dart_code_lab/model/model.dart';

String getPath(String fileName) =>
    Platform.script.resolve(fileName).toFilePath();

List loadSpeakersFromJson() => _loadFromJson("speakers.json", "speaker");

List loadSessionsFromJson() => _loadFromJson("sessions.json", "session");

List _loadFromJson(String fileName, String type) {
  List objects = [];
  File file = new File(getPath(path.join("../lib", fileName)));
  if (file.existsSync()) {
    List elements = JSON.decode(file.readAsStringSync());
    elements.forEach((Map element) {
      if (type == "speaker") {
        Speaker speaker = new Speaker.fromJson(element);
        objects.add(speaker);
      } else if (type == "session") {
        Session session = new Session.fromJson(element);
        objects.add(session);
      }
    });
  } else {
    //TODO zemri
  }

  return objects;
}
