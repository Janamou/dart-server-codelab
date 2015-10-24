library devfest_dart_code_lab.devfest_model;

class Speaker {
  int id;
  String name;
  String title;
  String company;
  String country;
  String bio;

  Speaker();

  Speaker.fromJson(Map map) {
    id = map["id"];
    name = map["name"];
    title = map["title"];
    company = map["company"];
    country = map["country"];
    bio = map["bio"];
  }

  String toString() => "name: $name,\n bio: $bio";
}

class Session {
  int id;
  String title;
  String description;
  String language;
  String complexity;
  List<Speaker> speakers = [];
  List<String> tags;

  Session();

  Session.fromJson(Map map) {
    id = map["id"];
    title = map["title"];
    description = map["description"];
    language = map["language"];
    complexity = map["complexity"];
    tags = map["tags"];
    if (map.containsKey("speakers")) {
      map["speakers"].forEach((Map speaker) {
        speakers.add(new Speaker.fromJson(speaker));
      });
    }
  }

  String toString() => "title: $title,\n description: $description";
}