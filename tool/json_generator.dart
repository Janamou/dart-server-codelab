library json_generator;

import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;

const String SOURCE_SESSIONS_FILE_NAME = "sessions-source.json";
const String SOURCE_SPEAKERS_FILE_NAME = "speakers-source.json";
const String SESSIONS_FILE_NAME = "sessions.json";
const String SPEAKERS_FILE_NAME = "speakers.json";
const String FOLDER_NAME = "../lib";

String getPath(String fileName) =>
    Platform.script.resolve(fileName).toFilePath();

/// Generator generates updated json files which are then loaded by server.
main() async {
  File sessionsFile = new File(getPath(SOURCE_SESSIONS_FILE_NAME));
  File speakersFile = new File(getPath(SOURCE_SPEAKERS_FILE_NAME));

  if (sessionsFile.existsSync() && speakersFile.existsSync()) {
    String sessionsContent = await sessionsFile.readAsString();
    String speakersContent = await speakersFile.readAsString();

    //we know that contents are JSON
    List sessions = JSON.decode(sessionsContent);
    List speakers = JSON.decode(speakersContent);

    speakers.forEach((Map speaker) {
      if (speaker.containsKey("featured")) {
        speaker.remove("featured");
      }

      if (speaker.containsKey("photoUrl")) {
        speaker.remove("photoUrl");
      }

      if (speaker.containsKey("tags")) {
        speaker.remove("tags");
      }

      if (speaker.containsKey("socials")) {
        speaker.remove("socials");
      }

      if (speaker.containsKey("badges")) {
        speaker.remove("badges");
      }
    });

    sessions.forEach((Map session) {
      if (session.containsKey("presentation")) {
        session.remove("presentation");
      }

      if (session.containsKey("video")) {
        session.remove("video");
      }

      if (session.containsKey("track")) {
        session.remove("track");
      }

      List sessionSpeakers = [];
      if (session.containsKey("speakers")) {
        session["speakers"].forEach((int speakerId) {
          Map sessionSpeaker = speakers
              .where((speaker) => speaker["id"] == speakerId)
              .toList()
              .first;
          sessionSpeakers.add(sessionSpeaker); //what if there is an error?
        });
        session["speakers"] = sessionSpeakers;
      }
    });

    File sessionsOutput =
        new File(getPath(path.join(FOLDER_NAME, SESSIONS_FILE_NAME)));
    sessionsOutput.writeAsStringSync(JSON.encode(sessions));

    File speakersOutput =
        new File(getPath(path.join(FOLDER_NAME, SPEAKERS_FILE_NAME)));
    speakersOutput.writeAsStringSync(JSON.encode(speakers));
  } else {
    //TODO some error
  }
}
