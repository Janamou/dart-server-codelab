library devfest_model;

class Talk {
  int id;
  String name;
  double duration;

  Talk();

  Talk.fromJson(Map map) {
    name = map["name"];
    duration = map["duration"];
  }

  Map toJson() => {"name": name, "duration": duration};

  String toString() => "name: $name, duration: $duration";
}

class Speaker {
  int id;
  String firstName;
  String lastName;
  String bio;

  Speaker();

  Speaker.fromJson(Map map) {
    firstName = map["firstName"];
    lastName = map["lastName"];
    bio = map["bio"];
  }

  Map toJson() => {"firstName": firstName, "lastName": lastName};

  String toString() => "firstName: $firstName, lastName: $lastName";
}