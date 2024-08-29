import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import '../models/search_result.dart';
import '../utils/util.dart';

abstract class BaseProvider<T> with ChangeNotifier {
  static String? _baseUrl;
  String _endPoint = "";
  late IOClient _ioClient;

  BaseProvider(String endPoint) {
    _endPoint = endPoint;
    _baseUrl = const String.fromEnvironment("baseUrl",
        defaultValue: "https://10.0.2.2:7198/");
    _ioClient = IOClient(createHttpClient());
  }

  static String? get baseUrl => _baseUrl;
  String get endPoint => _endPoint;
  IOClient get ioClient => _ioClient;

  HttpClient createHttpClient() {
    final HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    return httpClient;
  }

  Future<SearchResult<T>> get({dynamic filter}) async {
    var url = "$_baseUrl$_endPoint";

    if (filter != null) {
      var queryString = getQueryString(filter);
      url = "$url?$queryString";
    }

    var uri = Uri.parse(url);

    var response = await _ioClient.get(uri, headers: createHeaders());

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);

      var result = SearchResult<T>();
      result.count = data['count'];

      for (var item in data['result']) {
        result.result.add(fromJson(item));
      }

      return result;
    } else {
      throw Exception("Unknown error");
    }
  }

  T fromJson(data) {
    throw Exception("Method not implemented");
  }

  bool isValidResponse(http.Response response) {
    if (response.statusCode < 299) {
      return true;
    } else if (response.statusCode == 401) {
      throw new Exception("Unauthorized");
    } else {
      print(response.body);
      throw new Exception("Something bad happened, please try again");
    }
  }

  Future<T> insertJsonData(dynamic request) async {
    var url = "$_baseUrl$_endPoint";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request, toEncodable: myDateSerializer);
    var response =
        await _ioClient.post(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw new Exception("Unknown error");
    }
  }

  Future<T> insertMultipartData(Map<String, dynamic> formData) async {
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
    var response = await _ioClient.send(request);

    if (response.statusCode < 299) {
      var responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);
      return fromJson(data);
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      var responseBody = await response.stream.bytesToString();
      print(responseBody);
      throw Exception("Something bad happened, please try again");
    }
  }
Future<T> insertFileMultipartData(Map<String, dynamic> formData) async {
  var url = "$_baseUrl$_endPoint";
  var request = http.MultipartRequest(
    'POST',
    Uri.parse(url),
  );

  request.headers.addAll(createHeaders());

  for (var key in formData.keys) {
    var value = formData[key];

    if (value != null) {
      if (value is String && value.contains('/')) {
        // Assuming it's a file path
        var file = await http.MultipartFile.fromPath(key, value);
        request.files.add(file);
      }  else if (value is double) {
        // Convert numeric values to the desired format
        String formattedValue = value.toStringAsFixed(2).replaceAll('.', ',');
        request.fields[key] = formattedValue;
      }
      else {
        request.fields[key] = value.toString();
      }
    }
  }
  print('Request fields: ${request.fields}'); // Debugging: Log the fields to check the values before sending

  var response = await _ioClient.send(request);

  if (response.statusCode < 299) {
    var responseBody = await response.stream.bytesToString();
    var data = jsonDecode(responseBody);
    return fromJson(data);
  } else if (response.statusCode == 401) {
    throw Exception("Unauthorized");
  } else {
    var responseBody = await response.stream.bytesToString();
    print(responseBody);
    throw Exception("Something bad happened, please try again");
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
    final response = await _ioClient.put(url, headers: headers);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to cancel');
    }
  }

  Future<T> update(int id, [dynamic request]) async {
    var url = "$_baseUrl$_endPoint/$id";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request, toEncodable: myDateSerializer);
    var response =
        await _ioClient.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw new Exception("Unknown error");
    }
  }

  Future<T> updateMultipartData(int id, Map<String, dynamic> formData) async {
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

    var response = await _ioClient.send(request);

    if (response.statusCode < 299) {
      var responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);
      return fromJson(data);
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized");
    } else {
      var responseBody = await response.stream.bytesToString();
      print(responseBody);
      throw Exception("Something bad happened, please try again");
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