import 'package:studentoglasi_mobile/providers/base_provider.dart';
import '../models/PrijavePraksa/prijave_praksa.dart';
import 'dart:convert';

class PrijavePraksaProvider extends BaseProvider<PrijavePraksa> {
  PrijavePraksaProvider() : super('PrijavePraksa');
 @override
  PrijavePraksa fromJson(data) {
    // TODO: implement fromJson
    return PrijavePraksa.fromJson(data);
  }
   Future<List<PrijavePraksa>>  getPrijavePraksaByStudentId(int studentId) async {
  var url = "${BaseProvider.baseUrl}${endPoint}/student/$studentId";
    var uri = Uri.parse(url);

    var response = await ioClient.get(uri, headers: createHeaders());

     if (isValidResponse(response)) {
      var data = jsonDecode(response.body) as List;
      return data.map((e) => PrijavePraksa.fromJson(e)).toList();
    } else {
      throw Exception("Unknown error");
    }
  }
}