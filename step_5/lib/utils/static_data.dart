library devfest_dart_code_lab.static_data;

import 'package:devfest_dart_code_lab/model/model.dart';

final List<Speaker> speakers = [
  new Speaker()
    ..id = 14
    ..name = "Jana Moudrá"
    ..title = "Co-Founder"
    ..company = "Juicymo"
    ..country = "Czech Republic"
    ..bio =
        "GDE (Google Developer Expert) for Dart. Jana is a passionate developer and modern web and mobile technology evangelist. She is an event organiser for GDG Prague, where she arranges events for developers including public lectures, code labs and hackathons – covering a wide range of subjects including technologies Dart or Android. She loves to help other developers and spread the knowledge about these technologies. <br/><br/>Jana co-founded a company called Juicymo, where she works on juicy apps and products.",
  new Speaker()
    ..id = 15
    ..name = "Jakub Škvára"
    ..title = "Frontend engineer"
    ..company = "Shipito"
    ..country = "Czech Republic"
    ..bio =
        "Jakub is a member of GDG Prague and GDG ČVUT in Czech republic. He organised together with Jana Moudrá several Polymer and Dart code labs and a hackaton. He works as a frontend engineer for Shipito. Jakub is interested in modern Javascript frameworks, libraries and tools and loves clean code."
];

final List<Session> sessions = [
  new Session()
    ..id = 115
    ..title = "Let's play Dart!"
    ..description =
        "Dart is a language for the web by Google which is object oriented with optional types. You can use Dart to build great apps for the client-side, server-side and command line. <br/><br/>Come to listen to my story why I love Dart and why it makes me so much productive!"
    ..language = "en"
    ..complexity = "Intermediate"
    ..speakers = [speakers[0]]
    ..tags = ["Web", "Dart"],
  new Session()
    ..id = 116
    ..title = "Polymer vs other libraries"
    ..description =
        "Most modern front-end JavaScript libraries provide support for component based development. Components help separate large applications into standalone building blocks with specified communication API. Let's compare Polymer elements with components from React, Angular."
    ..language = "en"
    ..complexity = "Intermediate"
    ..speakers = [speakers[1]]
    ..tags = ["Web", "Polymer"]
];