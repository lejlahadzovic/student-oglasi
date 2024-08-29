import 'dart:convert';

import 'package:studentoglasi_mobile/models/PrijavaStipendija/prijave_stipendija.dart';
import 'package:studentoglasi_mobile/providers/base_provider.dart';

class PrijaveStipendijaProvider extends BaseProvider<PrijaveStipendija> {
  PrijaveStipendijaProvider() : super('PrijaveStipendija');
 @override
  PrijaveStipendija fromJson(data) {
    // TODO: implement fromJson
    return PrijaveStipendija.fromJson(data);
  }
   Future<List<PrijaveStipendija>>  getPrijaveStipendijaByStudentId(int studentId) async {
  var url = "${BaseProvider.baseUrl}${endPoint}/student/$studentId";
    var uri = Uri.parse(url);

    var response = await ioClient.get(uri, headers: createHeaders());

     if (isValidResponse(response)) {
      var data = jsonDecode(response.body) as List;
      return data.map((e) => PrijaveStipendija.fromJson(e)).toList();
    } else {
      throw Exception("Unknown error");
    }
  }
}
