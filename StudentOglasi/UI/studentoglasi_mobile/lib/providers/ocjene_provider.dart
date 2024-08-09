import 'dart:convert';

import 'package:studentoglasi_mobile/models/Ocjena/ocjena.dart';
import 'package:studentoglasi_mobile/models/Ocjena/ocjena_average.dart';
import 'package:studentoglasi_mobile/models/Ocjena/ocjena_insert.dart';
import 'package:studentoglasi_mobile/providers/base_provider.dart';

class OcjeneProvider extends BaseProvider<Ocjena> {
  OcjeneProvider() : super("Ocjene");

  @override
  Ocjena fromJson(data) {
    return Ocjena.fromJson(data);
  }

  Future<bool> insertOcjena(OcjenaInsert request) async {
    try {
      await insertJsonData(request.toJson());
      return true;
    } catch (e) {
      print('Failed to insert ocjena: $e');
      return false;
    }
  }

  Future<double> getAverageOcjena(int postId, String postType) async {
    var url = "${BaseProvider.baseUrl}$endPoint/$postId/$postType";
    var uri = Uri.parse(url);

    var response = await ioClient.get(uri, headers: createHeaders());

    if (isValidResponse(response)) {
      return double.parse(response.body);
    } else {
      throw Exception("Failed to fetch average rating");
    }
  }

  Future<List<OcjenaAverage>> getAverageOcjeneByPostType(String postType) async {
    var url = "${BaseProvider.baseUrl}$endPoint/average/$postType";
    var uri = Uri.parse(url);

    var response = await ioClient.get(uri, headers: createHeaders());

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body) as List;
      return data.map((e) => OcjenaAverage.fromJson(e)).toList();
    } else {
      throw Exception("Failed to fetch average ratings");
    }
  }

  Future<Ocjena?> getUserOcjena(int postId, String postType, int userId) async {
    var url = "${BaseProvider.baseUrl}$endPoint/$postId/$postType/$userId";
    var uri = Uri.parse(url);

    var response = await ioClient.get(uri, headers: createHeaders());

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return Ocjena.fromJson(data);
    } else {
      print("Failed to fetch user rating");
      return null;
    }
  }
}
