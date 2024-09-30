import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:studentoglasi_admin/models/search_result.dart';
import 'package:studentoglasi_admin/utils/util.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  static String? _baseUrl;
  String _endPoint = "";

  BaseProvider(String endPoint) {
    _endPoint = endPoint;
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "http://localhost:7198/");
  }

  String? get baseUrl => _baseUrl;
  String get endPoint => _endPoint;
  
  Future<SearchResult<T>> get({dynamic filter}) async {
    var url = "$_baseUrl$_endPoint";

    if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      var result = SearchResult<T>();

      result.count = data['count'];

      for (var item in data['result']) {
        result.result.add(fromJson(item));
      }

      return result;
    } else {
      throw new Exception("Unknown error");
    }
    // print("response: ${response.request} ${response.statusCode}, ${response.body}");
  }

  T fromJson(data) {
    throw Exception("Method not implemented");
  }

  bool isValidResponse(Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw new Exception("Unauthorized");
    } else {
      print(response.body);
      throw new Exception("Something bad happened please try again");
    }
  }

  Future<bool> delete(int? id) async {
    var url = Uri.parse('$_baseUrl$_endPoint/$id');
    var headers = createHeaders();
    final response = await http.delete(url, headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete');
    }
  }

  Future<bool> cancel(int? id, {int? entityId}) async {
    var url;
    if (entityId != null) {
      url = Uri.parse('$_baseUrl$_endPoint/$id/$entityId/cancel');
    } else {
      url = Uri.parse('$_baseUrl$_endPoint/$id/cancel');
    }

    var headers = createHeaders();
    final response = await http.put(url, headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to cancel');
    }
  }

  Future<bool> approve(int? id, {int? entityId}) async {
    var url;
    if (entityId != null) {
      url = Uri.parse('$_baseUrl$_endPoint/$id/$entityId/approve');
    } else {
      url = Uri.parse('$_baseUrl$_endPoint/$id/approve');
    }

    var headers = createHeaders();
    final response = await http.put(url, headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to approve');
    }
  }

  Future<T> insert(dynamic request) async {
    var url = "$_baseUrl$_endPoint";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request, toEncodable: myDateSerializer);
    var response = await http.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw new Exception("Unknown error");
    }
  }

  Future<T> insertWithImage(Map<String, dynamic> formData) async {
    var url = "$_baseUrl$_endPoint";
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.headers.addAll(createHeaders());

    formData.forEach((key, value) async {
      if (key == 'filePath' && value != null) {
        var filePath = value.toString();
        var file = await http.MultipartFile.fromPath('slika', filePath);
        request.files.add(file);
      } else {
        request.fields[key] = value.toString();
      }
    });
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

  Future<T> update(int id, [dynamic request]) async {
    var url = "$_baseUrl$_endPoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request, toEncodable: myDateSerializer);
    var response = await http.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw new Exception("Unknown error");
    }
  }

  Future<T> updateWithImage(int id, Map<String, dynamic> formData) async {
    var url = "$_baseUrl$_endPoint/$id";
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse(url),
    );

    request.headers.addAll(createHeaders());

    formData.forEach((key, value) async {
      if (key == 'filePath' && value != null) {
        var filePath = value.toString();
        var file = await http.MultipartFile.fromPath('slika', filePath);
        request.files.add(file);
      } else {
        request.fields[key] = value.toString();
      }
    });
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw new Exception("Unknown error");
    }
  }

  Map<String, String> createHeaders() {
    String username = Authorization.username ?? '';
    String password = Authorization.password ?? '';

    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    var headers = {
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };

    return headers;
  }

  String getQueryString(Map params,
      {String prefix = '&', bool inRecursion = false}) {
    String query = '';
    params.forEach((key, value) {
      if (inRecursion) {
        if (key is int) {
          key = '[$key]';
        } else if (value is List || value is Map) {
          key = '.$key';
        } else {
          key = '.$key';
        }
      }
      if (value is String || value is int || value is double || value is bool) {
        var encoded = value;
        if (value is String) {
          encoded = Uri.encodeComponent(value);
        }
        query += '$prefix$key=$encoded';
      } else if (value is DateTime) {
        query += '$prefix$key=${(value as DateTime).toIso8601String()}';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query +=
              getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });
    return query;
  }

  dynamic myDateSerializer(dynamic object) {
    if (object is DateTime) {
      return object.toIso8601String();
    }
    return object;
  }
}
