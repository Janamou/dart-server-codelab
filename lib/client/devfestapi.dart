// This is a generated file (see the discoveryapis_generator project).

library devfest_dart_code_lab.devFestApi.client;

import 'dart:core' as core;
import 'dart:async' as async;
import 'dart:convert' as convert;

import 'package:_discoveryapis_commons/_discoveryapis_commons.dart' as commons;
import 'package:http/http.dart' as http;
import 'package:devfest_dart_code_lab/model/model.dart';
export 'package:_discoveryapis_commons/_discoveryapis_commons.dart' show
    ApiRequestError, DetailedApiRequestError;

const core.String USER_AGENT = 'dart-api-client devFestApi/v1';

class DevFestApi {

  final commons.ApiRequester _requester;

  SessionsResourceResourceApi get sessionsResource => new SessionsResourceResourceApi(_requester);
  SpeakersResourceResourceApi get speakersResource => new SpeakersResourceResourceApi(_requester);

  DevFestApi(http.Client client, {core.String rootUrl: "http://localhost:8080/", core.String servicePath: "devFestApi/v1/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
}


class SessionsResourceResourceApi {
  final commons.ApiRequester _requester;

  SessionsResourceResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Request parameters:
   *
   * [id] - Path parameter: 'id'.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future deleteSession(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _downloadOptions = null;

    _url = 'sessions/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Request parameters:
   *
   * Completes with a [core.List<Session>].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<core.List<Session>> getSessions() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'sessions';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => data.map((value) => SessionFactory.fromJson(value)).toList());
  }

  /**
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Session].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Session> postSession(Session request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode(SessionFactory.toJson(request));
    }

    _url = 'sessions';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => SessionFactory.fromJson(data));
  }

}


class SpeakersResourceResourceApi {
  final commons.ApiRequester _requester;

  SpeakersResourceResourceApi(commons.ApiRequester client) : 
      _requester = client;

  /**
   * Request parameters:
   *
   * [id] - Path parameter: 'id'.
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future deleteSpeaker(core.String id) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (id == null) {
      throw new core.ArgumentError("Parameter id is required.");
    }

    _downloadOptions = null;

    _url = 'speakers/' + commons.Escaper.ecapeVariable('$id');

    var _response = _requester.request(_url,
                                       "DELETE",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => null);
  }

  /**
   * Request parameters:
   *
   * Completes with a [core.List<Speaker>].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<core.List<Speaker>> getSpeakers() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'speakers';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => data.map((value) => SpeakerFactory.fromJson(value)).toList());
  }

  /**
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Speaker].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Speaker> postSpeaker(Speaker request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode(SpeakerFactory.toJson(request));
    }

    _url = 'speakers';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => SpeakerFactory.fromJson(data));
  }

}



class SessionFactory {
  static Session fromJson(core.Map _json) {
    var message = new Session();
    if (_json.containsKey("complexity")) {
      message.complexity = _json["complexity"];
    }
    if (_json.containsKey("description")) {
      message.description = _json["description"];
    }
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    if (_json.containsKey("language")) {
      message.language = _json["language"];
    }
    if (_json.containsKey("speakers")) {
      message.speakers = _json["speakers"].map((value) => SpeakerFactory.fromJson(value)).toList();
    }
    if (_json.containsKey("tags")) {
      message.tags = _json["tags"];
    }
    if (_json.containsKey("title")) {
      message.title = _json["title"];
    }
    return message;
  }

  static core.Map toJson(Session message) {
    var _json = new core.Map();
    if (message.complexity != null) {
      _json["complexity"] = message.complexity;
    }
    if (message.description != null) {
      _json["description"] = message.description;
    }
    if (message.id != null) {
      _json["id"] = message.id;
    }
    if (message.language != null) {
      _json["language"] = message.language;
    }
    if (message.speakers != null) {
      _json["speakers"] = message.speakers.map((value) => SpeakerFactory.toJson(value)).toList();
    }
    if (message.tags != null) {
      _json["tags"] = message.tags;
    }
    if (message.title != null) {
      _json["title"] = message.title;
    }
    return _json;
  }
}

class SpeakerFactory {
  static Speaker fromJson(core.Map _json) {
    var message = new Speaker();
    if (_json.containsKey("bio")) {
      message.bio = _json["bio"];
    }
    if (_json.containsKey("company")) {
      message.company = _json["company"];
    }
    if (_json.containsKey("country")) {
      message.country = _json["country"];
    }
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    if (_json.containsKey("name")) {
      message.name = _json["name"];
    }
    if (_json.containsKey("title")) {
      message.title = _json["title"];
    }
    return message;
  }

  static core.Map toJson(Speaker message) {
    var _json = new core.Map();
    if (message.bio != null) {
      _json["bio"] = message.bio;
    }
    if (message.company != null) {
      _json["company"] = message.company;
    }
    if (message.country != null) {
      _json["country"] = message.country;
    }
    if (message.id != null) {
      _json["id"] = message.id;
    }
    if (message.name != null) {
      _json["name"] = message.name;
    }
    if (message.title != null) {
      _json["title"] = message.title;
    }
    return _json;
  }
}

