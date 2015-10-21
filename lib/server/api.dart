library devfest_server_api;

import 'package:rpc/rpc.dart';
import 'package:devfest_dart_code_lab/model/model.dart';
import 'package:devfest_dart_code_lab/utils/json_loaders.dart';

@ApiClass(version: 'v1')
class DevFestApi {
  @ApiResource()
  SpeakersResource speakersResource = new SpeakersResource();

  @ApiResource()
  SessionsResource sessionsResource = new SessionsResource();
}

class SpeakersResource {
  List _speakers;

  // We are not having database and we need to provide some data to the API.
  // So we will load data from our prepared JSON file into a memory;
  SpeakersResource() {
    _speakers = loadSpeakersFromJson();
  }

  @ApiMethod(path: 'speakers')
  List<Speaker> getSpeakers() => _speakers;

  @ApiMethod(path: 'speakers', method: 'POST')
  Speaker postSpeaker(Speaker speaker) {
    if (speaker == null) {
      throw new ArgumentError("Speaker can't be null");
    }
    _speakers.add(speaker);
    return speaker;
  }

  @ApiMethod(path: 'speakers/{id}', method: 'DELETE')
  VoidMessage deleteSpeaker(String id) {
    Speaker speaker = _speakers
        .where((speaker) => speaker.id == int.parse(id))
        .toList()
        .first;
    _speakers.remove(speaker);
    return null;
  }

  @ApiMethod(path: 'speakers/{id}')
  Speaker getSpeaker(String id) {
    return _speakers
        .where((speaker) => speaker.id == int.parse(id))
        .toList()
        .first;
  }
}

class SessionsResource {
  List _sessions;

  SessionsResource() {
    _sessions = loadSessionsFromJson();
  }

  @ApiMethod(path: 'sessions')
  List<Session> getSessions() => _sessions;

  @ApiMethod(path: 'sessions', method: 'POST')
  Session postSession(Session session) {
    if (session == null) {
      throw new ArgumentError("Session can't be null");
    }
    _sessions.add(session);
    return session;
  }

  @ApiMethod(path: 'sessions/{id}', method: 'DELETE')
  VoidMessage deleteSession(String id) {
    Session session = _sessions
        .where((session) => session.id == int.parse(id))
        .toList()
        .first;
    _sessions.remove(session);
    return null;
  }

  @ApiMethod(path: 'sessions/{id}')
  Session getSession(String id) {
    return _sessions
    .where((session) => session.id == int.parse(id))
    .toList()
    .first;
  }
}
