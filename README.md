# Dart server-side Code Lab
The goal of this code lab is to create a server side API with Dart using the [rpc](https://pub.dartlang.org/packages/rpc) package. 
We create a simple API with list of **sessions** and **speakers** from DevFest Istanbul 2015.

You will learn:
* how to write applications in Dart
* how to work on server-side with Dart's rpc package
* how to use logger

Download the prepared project from [Github](https://github.com/Janamou/dart-server-codelab) and open it in editor. We prepared everything important for you.
Project is divided into steps according to this Code Lab. 

Try to run the application from **step_5/** and see how it works. 
To be able to run it, you need to call `pub get` in the step_5 project folder. Then run the script **bin/server.dart**.

## Step 1 - Let's prepare our API
We start with the folder `step_0_start`.

First explore the **pubspec.yaml** file in the project. All important metadata for project are present and the dependencies for rpc library are present:

```yaml
  ...
dependencies:
  rpc: ^0.5.5
  http: '>=0.11.1 <0.12.0'
  crypto: '>=0.9.0 <0.10.0'
  _discoveryapis_commons: '>=0.1.0 <0.2.0'
```

Run `pub get` in the project folder.

### DevFestApi class
We write a class for our Dart API. We name this class `DevFestApi` and store it into the file `lib/server/api.dart`.

```dart
library devfest_dart_code_lab.devfest_api;

class DevFestApi {
  // here will be contents of the class.
}
```

We use library [rpc](https://pub.dartlang.org/packages/rpc) which is a library for creating RESTful server-side Dart APIs from the Dart team.

To be able to use it, we need to import it:

```dart
library devfest_dart_code_lab.devfest_api;

import 'package:rpc/rpc.dart';

class DevFestApi {
  // here will be contents of the class.
}
```

We need to provide annotation `@ApiClass` to our `DevFestApi` class to be able to say that it wraps our API.
It is required to provide a `version` of the API.

```dart
@ApiClass(version: 'v1')
class DevFestApi {
  // here will be contents of the class.
}
```
### Resource classes

Our API provides list of all speakers and sessions. These lists are contained in resource classes.
We create two resource classes - `SpeakersResource` class and `SessionsResource` class in the `api.dart`. 

```dart

@ApiClass(version: 'v1')
class DevFestApi {
  // here will be contents of the class.
}

class SpeakersResource {
  List _speakers;

  SpeakersResource() {
    _speakers = [];
  }
}

class SessionsResource {
  List _sessions;

  SessionsResource() {
    _sessions = [];  
  }
}  
```

These classes are instantiated in our `DevFestApi` class and the annotation `@ApiResource` needs to be provided to them.

```dart
@ApiClass(version: 'v1')
class DevFestApi {

  DevFestApi();

  @ApiResource()
  SpeakersResource speakersResource = new SpeakersResource();

  @ApiResource()
  SessionsResource sessionsResource = new SessionsResource();
}
```

### Model
To be able to return list of all speakers and sessions, model classes need to be implemented.
See the `lib/model/model.dart` file for the implementation. 

Class `Speaker` and `Session` both have its attributes, default constructor and one named constructor
`Speaker.fromJson()` and `Session.fromJson()`. This constructor will be later used for creating new `Speaker` and `Session` object from
provided JSON - JSON is converted to `Map` and this Map is used in our named constructors to fill the attributes with values from
it.

Finally the `toString()` method is implemented in both classes to get the nice `String` representation of every
object.

Notice how a `List` of speakers is generated in `Session.fromJson()` constructor. For every speaker in session, the `Speaker` object
is created and added to the List of speakers `List<Speaker>`.

Also note that `List` (or `Map`) in model classes needs to be **typed** or the rpc library will fail to parse the API.

```dart
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
```

### API methods
Now we implement API methods for our resources. We implement `GET`, `POST` and `DELETE` methods fo speakers and sessions.

#### `SpeakersResource` API methods

We define methods:
* `getSpeakers()` - returns a `List` of all speakers,
* `postSpeaker(Speaker speaker)` - creates a new speaker, e.g. adds it to the List of speakers,
* `deleteSpeaker(String id)` - deletes a speaker by `id`, e.g. finds it in the List by id and deletes it,
* `getSpeaker(String id)` - returns speaker by `id`

All API methods have to have the `@ApiMethod` annotation to be able to be provided by the API. 
We need to specify the `path` which is used for this method in the annotation. 
Path supports also parameters (as you can see in `getSpeaker()` method).
For the other methods than `GET`, the `method` has to be also specified in the annotation 
(in our example it is `POST` and `DELETE`).

Our API methods work with the model so we need to import it:

```dart
import '../model/model.dart';
```

Note that we provide model classes directly as a parameters/return types of the method - we don't need to use JSON because rpc library
does this for us.

And also if the API method doesn't return anything, we need to provide a special return type `VoidMessage` and we `return null;`.

```dart
class SpeakersResource {
  List _speakers;

  SpeakersResource() {
    _speakers = [];
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
```

#### `SessionsResource` API methods

`SessionsResource` class is similar to `SpeakersResource` class.

We define also similar methods:
* `getSessions()`
* `postSession(Session session)`
* `deleteSession(String id)`
* `getSession(String id)`

```dart
class SessionsResource {
  List _sessions;

  SessionsResource() {
    _sessions = [];
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
```

Now we have our API finished and the last thing we need to create is the server script.
The script `server.dart` resides in the `bin` folder.

We need to create here the instance of `ApiServer` first. Then we use it to add an API by calling
 `_apiServer.addApi(new DevFestApi())`.
 
Now we create an instance of the `HttpServer` class and bind it to `localhost:8080`. 

Server listens to the requests and uses default HTTP request handler which comes with the `ApiServer` class.

Also notice using a `Logger` to print info about server start into the console.

```dart
library devfest_server;

import 'dart:io';
import 'package:logging/logging.dart';
import 'package:rpc/rpc.dart';
import '../lib/server/api.dart';

final ApiServer apiServer = new ApiServer(prettyPrint: true);

main() async {
  Logger.root..level = Level.INFO..onRecord.listen(print);

  apiServer.addApi(new DevFestApi());
  HttpServer server = await HttpServer.bind(InternetAddress.ANY_IP_V4, 8080);
  server.listen(apiServer.httpRequestHandler);
  print('Server listening on http://${server.address.host}: ${server.port}');
}
```

## Step 2 - Run the application
Run the `bin/server.dart` either from your IDE or from console with command:
```bash
dart bin/server.dart
```

Try our resources on `localhost:8080/devFestApi/v1/speakers` and `http://localhost:8080/devFestApi/v1/sessions` in the web browser.
Our API returns empty lists because our lists in the API classes are empty.

We fill them in the next step.

Also notice the name `devFestApi` in the url. Why is it there? Our API class is named `DevFestApi`, so the API name is named according to this 
class in the camelCase style. But it is also possible to provide different name to the API class throught the `@ApiClass` annotation.

## Step 3 - Fill lists with data
We are not using any database in this code lab so we need to provide the data in the code and load them into our lists
after resource creation.

See the `lib/utils/static_data.dart` file.

Here is a list of two speakers and sessions for them. We will use these lists in our API resource class to initialize the `List` objects.

```dart
List<Speaker> speakers = [
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

List<Session> sessions = [
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
```

Now we need to initialize our lists in `DevFestApi` class. 
First we add an import into a `DevFestApi` class to `lib/utils/static_data.dart`. 

```dart
import '../utils/static_data.dart';
```

We set the values of lists in constructors of the resource classes.

```dart
class SpeakersResource {
  List _speakers;

  SpeakersResource() {
    _speakers = speakers;
  }

  //other contents of the class
}

class SessionsResource {
  List _sessions;

  SessionsResource() {
    _sessions = sessions;
  }
  
  //other contents of the class
}
```

Stop current server and run it again. You should be able to see two speakers and two sesions.

Warning: If you see "Failed to create server socket" error, previous process might still be using port 8080. 
Use one of the following commands in the command line.

Mac or Linux:
```bash
lsof -i :8080
```

Windows:
```bash
netstat -ano
```

and then kill the process.

## Step 4 - Test the API

Now we need to test that our API works. We have methods on paths:
* GET localhost:8080/devFestApi/v1/speakers
* GET localhost:8080/devFestApi/v1/speakers/{id}
* GET localhost:8080/devFestApi/v1/sessions
* GET localhost:8080/devFestApi/v1/sessions/{id}
* DELETE localhost:8080/devFestApi/v1/speakers/{id}
* DELETE localhost:8080/devFestApi/v1/sessions/{id}
* POST localhost:8080/devFestApi/v1/speakers
* POST localhost:8080/devFestApi/v1/sessions

{id} means that the id of a speaker or session is added.

###GET

Trying `GET` methods is easy because we can try it in the web browser. Try this in the web browser:
* localhost:8080/devFestApi/v1/speakers
* localhost:8080/devFestApi/v1/speakers/14
* localhost:8080/devFestApi/v1/sessions
* localhost:8080/devFestApi/v1/sessions/115

The ids correspond to ids of items in lists from `lib/utils/static_data.dart`.

Trying `DELETE` and `POST` methods is harder because we need to install either tool like [curl](http://curl.haxx.se/) or we can use some
extension to Chrome (like [Advanced REST client](https://chrome.google.com/webstore/detail/advanced-rest-client/hgmloofddffdnphfgcellkdfbfbjeloo) or [Postman](https://chrome.google.com/webstore/detail/postman/fhbjgbiflinjbdggehcddcbncdddomop)).

We can also test a `GET` method with curl:

```bash
curl http://localhost:8080/devFestApi/v1/speakers
curl http://localhost:8080/devFestApi/v1/sessions
```

### DELETE 
Try the `DELETE` methods and see how lists of our resources are now having only one element.
```bash
curl -X "DELETE" http://localhost:8080/devFestApi/v1/speakers/14
curl -X "DELETE" http://localhost:8080/devFestApi/v1/sessions/115
```

### POST
With the `POST` request we need to also send the data in a format of JSON. 

For Mac/Linux:
```bash
curl -H "Content-Type: application/json" -X "POST" -d '{"id":100,"name":"The test speaker"}' http://localhost:8080/devFestApi/v1/speakers
curl -H "Content-Type: application/json" -X "POST" -d '{"id":500,"title":"The test session"}' http://localhost:8080/devFestApi/v1/sessions
```

For Windows:
```bash
curl -H "Content-Type: application/json" -X "POST" -d "{\"id\":100,\"name\":\"The test speaker\"}" http://localhost:8080/devFestApi/v1/speakers
curl -H "Content-Type: application/json" -X "POST" -d "{\"id\":500,\"title\":\"The test session\"}" http://localhost:8080/devFestApi/v1/sessions
```

## Step 5 - Fill lists with data from JSON
Previous steps used the static data from lists in a `lib/utils/static_data.dart`. We don't use database in this code lab but we want to have still more
then two items in our resources. 

So we parse the prepared `lib/sessions.json` and `lib/speakers.json` which are generated from JSON files from official DevFest
website and fill the lists with these data (original JSON had unnecessary tags for our purpose and speakers were only a list of ids).

This functionality is already implemented in `lib/utils/json_loaders.dart`. Take a look at the code. Code parses the JSON files for speakers and sessions
and generates a List of objects (`Speaker` and `Session`) for them using the `.toJson()` constructor for every object.

And then we need to add an import to our `DevFestApi` class:

```dart
import '../utils/json_loaders.dart';
```
And use it in our resource constructors:

```dart
class SpeakersResource {
  List _speakers;

  SpeakersResource() {
    _speakers = loadSpeakersFromJson();
  }

  //other contents of the class
}

class SessionsResource {
  List _sessions;

  SessionsResource() {
    _sessions = loadSessionsFromJson();
  }
  
  //other contents of the class
}
```
Stop current server and run it again.

## Resources

* [Dartlang website](http://www.dartlang.org)
* [Dart news](http://news.dartlang.org/)
* [pubspec.yaml info](https://www.dartlang.org/tools/pub/pubspec.html)
* [Project structure](https://www.dartlang.org/tools/pub/package-layout.html)
* [Dart on server](https://www.dartlang.org/server/)
* [All Dart libraries on pub](https://pub.dartlang.org)
* [rpc library](https://pub.dartlang.org/packages/rpc)
* [Dartisans community on G+](http://g.co/dartisans)
