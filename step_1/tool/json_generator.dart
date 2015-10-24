library json_generator;

import 'dart:io';
import 'dart:convert';

/// This script takes two source JSON files for sessions and speakers downloaded
/// from the DevFest website and generates new JSON files with updated structure
/// which are then used by server.

const String sourceSessionsFileName = "sessions-source.json";
const String sourceSpeakersFileName = "speakers-source.json";
const String sessionsFileName = "sessions.json";
const String speakersFileName = "speakers.json";

/// Returns Uri to [fileName] relative to the running script.
Uri getPath(String fileName) => Platform.script.resolve(fileName);

/// Generator generates updated JSON files which are then loaded by server.
main() async {
  File sessionsFile = new File.fromUri(getPath(sourceSessionsFileName));
  File speakersFile = new File.fromUri(getPath(sourceSpeakersFileName));

  if (sessionsFile.existsSync() && speakersFile.existsSync()) {
    String sessionsContent = await sessionsFile.readAsString();
    String speakersContent = await speakersFile.readAsString();

    //we know that content of files is a JSON - we decode them
    List sessions = JSON.decode(sessionsContent);
    List speakers = JSON.decode(speakersContent);

    _updateSpeakers(speakers);
    _updateSessions(sessions, speakers);
  } else {
    print("ERROR: Source .json files don't exist!");
  }
}

/// Updates speakers JSON - removes unneeded properties.
///
/// New file is saved into a lib/ folder.
void _updateSpeakers(List speakers) {
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

  _saveJson(speakersFileName, speakers);
}

/// Updates sessions JSON - removes unneeded properties and updates some.
/// Sessions JSON now contains also [speakers].
///
/// New file is saved into a lib/ folder.
void _updateSessions(List sessions, List speakers) {
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

    // Finds speakers in speakers JSON by id and adds them also here - to
    // the appropriate session.
    // Source JSON file stores only speaker ids here, we will store full
    // speaker object here.
    List sessionSpeakers = [];
    if (session.containsKey("speakers")) {
      session["speakers"].forEach((int speakerId) {
        Map sessionSpeaker = speakers
            .where((speaker) => speaker["id"] == speakerId)
            .toList()
            .first;
        sessionSpeakers.add(sessionSpeaker);
      });
      session["speakers"] = sessionSpeakers;
    }
  });

  _saveJson(sessionsFileName, sessions);
}

/// Saves List of [items] as a JSON into file.
_saveJson(String fileName, List items) async {
  File output = new File.fromUri(getPath("../lib/$fileName"));
  await output.writeAsString(JSON.encode(items));
}
