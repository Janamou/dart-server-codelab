library devfest_server_api;

import 'package:rpc/rpc.dart';
import 'package:devfest_dart_code_lab/model/model.dart';

@ApiClass(version: 'v1')
class DevFestApi {
  @ApiResource()
  SpeakersResource speakersResource = new SpeakersResource();

  @ApiResource()
  TalksResource talksResource = new TalksResource();
}

class SpeakersResource {
  final List _speakers = [new Speaker()..firstName = "Jana"];

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
    Speaker speaker =
    _speakers.where((speaker) => speaker.id == int.parse(id)).toList().first;
    _speakers.remove(speaker);
    return null;
  }
}

class TalksResource {
  final List _talks = [];

  @ApiMethod(path: 'talks')
  List<Talk> getTalks() => _talks;

  @ApiMethod(path: 'talks', method: 'POST')
  Talk postTalk(Talk talk) {
    if (talk == null) {
      throw new ArgumentError("Talk can't be null");
    }
    _talks.add(talk);
    return talk;
  }

  @ApiMethod(path: 'talks/{id}', method: 'DELETE')
  VoidMessage deleteTalk(String id) {
    Talk talk =
    _talks.where((talk) => talk.id == int.parse(id)).toList().first;
    _talks.remove(talk);
    return null;
  }
}
