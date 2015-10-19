library devfest_server_api;

import 'package:rpc/rpc.dart';
import 'package:devfest_dart_code_lab/model/model.dart';

@ApiClass(version: 'v1')
class DevFestApi {
  @ApiResource()
  SpeakersResource speakersResource = new SpeakersResource();

  @ApiResource()
  SessionsResource sessionsResource = new SessionsResource();
}

class SpeakersResource {
  final List _speakers = [
    new Speaker()
      ..id = 1
      ..name = "Jana Moudrá"
      ..title = "Co-Founder"
      ..company = "Juicymo"
      ..country = "Czech Republic"
      ..bio =
          "GDE (Google Developer Expert) for Dart. Jana is a passionate developer and modern web and mobile technology evangelist. She is an event organiser for GDG Prague, where she arranges events for developers including public lectures, code labs and hackathons – covering a wide range of subjects including technologies Dart or Android. She loves to help other developers and spread the knowledge about these technologies. <br/><br/>Jana co-founded a company called Juicymo, where she works on juicy apps and products.",
    new Speaker()
      ..id = 2
      ..name = "Jakub Škvára"
      ..title = "Frontend engineer"
      ..company = "Shipito"
      ..country = "Czech Republic"
      ..bio =
          "Jakub is a member of GDG Prague and GDG ČVUT in Czech republic. He organised together with Jana Moudrá several Polymer and Dart code labs and a hackaton. He works as a frontend engineer for Shipito. Jakub is interested in modern Javascript frameworks, libraries and tools and loves clean code."
  ];

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
}

class SessionsResource {
  final List _sessions = [
    new Session()
      ..id = 1
      ..title = "Let's play Dart!"
      ..description =
          "Dart is a language for the web by Google which is object oriented with optional types. You can use Dart to build great apps for the client-side, server-side and command line. <br/><br/>Come to listen to my story why I love Dart and why it makes me so much productive!"
      ..speakers = [
        new Speaker()
          ..id = 1
          ..name = "Jana Moudrá"
          ..title = "Co-Founder"
          ..company = "Juicymo"
          ..country = "Czech Republic"
          ..bio =
              "GDE (Google Developer Expert) for Dart. Jana is a passionate developer and modern web and mobile technology evangelist. She is an event organiser for GDG Prague, where she arranges events for developers including public lectures, code labs and hackathons – covering a wide range of subjects including technologies Dart or Android. She loves to help other developers and spread the knowledge about these technologies. <br/><br/>Jana co-founded a company called Juicymo, where she works on juicy apps and products.",
      ]
      ..language = "en"
      ..complexity = "Intermediate"
      ..tags = ["Web", "Dart"],
    new Session()
      ..id = 2
      ..title = "Polymer vs other libraries"
      ..description =
          "Most modern front-end JavaScript libraries provide support for component based development. Components help separate large applications into standalone building blocks with specified communication API. Let's compare Polymer elements with components from React, Angular."
      ..speakers = [
        new Speaker()
          ..id = 2
          ..name = "Jakub Škvára"
          ..title = "Frontend engineer"
          ..company = "Shipito"
          ..country = "Czech Republic"
          ..bio =
              "Jakub is a member of GDG Prague and GDG ČVUT in Czech republic. He organised together with Jana Moudrá several Polymer and Dart code labs and a hackaton. He works as a frontend engineer for Shipito. Jakub is interested in modern Javascript frameworks, libraries and tools and loves clean code."
      ]
      ..language = "en"
      ..complexity = "Intermediate"
      ..tags = ["Web", "Polymer"]
  ];

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
}
