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

  SpeakersResourceResourceApi get speakersResource => new SpeakersResourceResourceApi(_requester);
  TalksResourceResourceApi get talksResource => new TalksResourceResourceApi(_requester);

  DevFestApi(http.Client client, {core.String rootUrl: "http://localhost:8080/", core.String servicePath: "devFestApi/v1/"}) :
      _requester = new commons.ApiRequester(client, rootUrl, servicePath, USER_AGENT);
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


class TalksResourceResourceApi {
  final commons.ApiRequester _requester;

  TalksResourceResourceApi(commons.ApiRequester client) : 
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
  async.Future deleteTalk(core.String id) {
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

    _url = 'talks/' + commons.Escaper.ecapeVariable('$id');

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
   * Completes with a [core.List<Talk>].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<core.List<Talk>> getTalks() {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;


    _url = 'talks';

    var _response = _requester.request(_url,
                                       "GET",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => data.map((value) => TalkFactory.fromJson(value)).toList());
  }

  /**
   * [request] - The metadata request object.
   *
   * Request parameters:
   *
   * Completes with a [Talk].
   *
   * Completes with a [commons.ApiRequestError] if the API endpoint returned an
   * error.
   *
   * If the used [http.Client] completes with an error when making a REST call,
   * this method will complete with the same error.
   */
  async.Future<Talk> postTalk(Talk request) {
    var _url = null;
    var _queryParams = new core.Map();
    var _uploadMedia = null;
    var _uploadOptions = null;
    var _downloadOptions = commons.DownloadOptions.Metadata;
    var _body = null;

    if (request != null) {
      _body = convert.JSON.encode(TalkFactory.toJson(request));
    }

    _url = 'talks';

    var _response = _requester.request(_url,
                                       "POST",
                                       body: _body,
                                       queryParams: _queryParams,
                                       uploadOptions: _uploadOptions,
                                       uploadMedia: _uploadMedia,
                                       downloadOptions: _downloadOptions);
    return _response.then((data) => TalkFactory.fromJson(data));
  }

}



class SpeakerFactory {
  static Speaker fromJson(core.Map _json) {
    var message = new Speaker();
    if (_json.containsKey("bio")) {
      message.bio = _json["bio"];
    }
    if (_json.containsKey("firstName")) {
      message.firstName = _json["firstName"];
    }
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    if (_json.containsKey("lastName")) {
      message.lastName = _json["lastName"];
    }
    return message;
  }

  static core.Map toJson(Speaker message) {
    var _json = new core.Map();
    if (message.bio != null) {
      _json["bio"] = message.bio;
    }
    if (message.firstName != null) {
      _json["firstName"] = message.firstName;
    }
    if (message.id != null) {
      _json["id"] = message.id;
    }
    if (message.lastName != null) {
      _json["lastName"] = message.lastName;
    }
    return _json;
  }
}

class TalkFactory {
  static Talk fromJson(core.Map _json) {
    var message = new Talk();
    if (_json.containsKey("duration")) {
      message.duration = _json["duration"];
    }
    if (_json.containsKey("id")) {
      message.id = _json["id"];
    }
    if (_json.containsKey("name")) {
      message.name = _json["name"];
    }
    return message;
  }

  static core.Map toJson(Talk message) {
    var _json = new core.Map();
    if (message.duration != null) {
      _json["duration"] = message.duration;
    }
    if (message.id != null) {
      _json["id"] = message.id;
    }
    if (message.name != null) {
      _json["name"] = message.name;
    }
    return _json;
  }
}

