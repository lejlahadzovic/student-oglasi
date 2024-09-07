import 'dart:convert';

import 'package:studentoglasi_mobile/models/Praksa/praksa.dart';
import 'package:studentoglasi_mobile/providers/base_provider.dart';
import '../models/search_result.dart';

class PraksaProvider extends BaseProvider<Praksa> {
  PraksaProvider() : super('Prakse');
  @override
  Praksa fromJson(data) {
    // TODO: implement fromJson
    return Praksa.fromJson(data);
  }

  Future<SearchResult<Praksa>> getRecommended(int studentId) async {
    var url = "${BaseProvider.baseUrl}${endPoint}/recommendations/$studentId";
    var uri = Uri.parse(url);
    var response = await ioClient.get(uri, headers: createHeaders());

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      var result = SearchResult<Praksa>();

      result.count = data.length;

      for (var item in data) {
        result.result.add(fromJson(item));
      }

      return result;
    } else {
      throw Exception("Unknown error");
    }
  }
}
