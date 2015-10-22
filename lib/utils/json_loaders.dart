library json_loaders;

import 'dart:convert';
import 'dart:io';
import 'package:devfest_dart_code_lab/model/model.dart';

const String sessionsFileName = "sessions.json";
const String speakersFileName = "speakers.json";

/// Returns Uri to [fileName] relative to the running script.
Uri getPath(String fileName) => Platform.script.resolve(fileName);

/// Returns [List] of speakers from a JSON file.
List loadSpeakersFromJson() => _loadFromJson(speakersFileName);

/// Returns [List] of sessions from a JSON file.
List loadSessionsFromJson() => _loadFromJson(sessionsFileName);

/// Returns List of converted objects from JSON provided by file of [fileName].
List _loadFromJson(String fileName) {
  List objects = [];
  File file = new File.fromUri(getPath("../lib/$fileName"));

  if (file.existsSync()) {
    List elements = JSON.decode(file.readAsStringSync());

    Object object;
    elements.forEach((Map element) {
      if (fileName == speakersFileName) {
        object = new Speaker.fromJson(element);
      } else if (fileName == sessionsFileName) {
        object = new Session.fromJson(element);
      }

      objects.add(object);
    });
  } else {
    print("ERROR: .json file $fileName doesn't exist!");
  }
  return objects;
}
