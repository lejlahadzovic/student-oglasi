import 'dart:convert';

import 'package:studentoglasi_mobile/models/Rezervacije/rezervacije.dart';
import 'package:studentoglasi_mobile/providers/base_provider.dart';

class RezervacijeProvider extends BaseProvider<Rezervacije> {
  RezervacijeProvider() : super('Rezervacije');
 @override
  Rezervacije fromJson(data) {
    // TODO: implement fromJson
    return Rezervacije.fromJson(data);
  }
   Future<List<Rezervacije>>  getRezervacijeByStudentId(int studentId) async {
  var url = "${BaseProvider.baseUrl}${endPoint}/student/$studentId";
    var uri = Uri.parse(url);

    var response = await ioClient.get(uri, headers: createHeaders());

     if (isValidResponse(response)) {
      var data = jsonDecode(response.body) as List;
      return data.map((e) => Rezervacije.fromJson(e)).toList();
    } else {
      throw Exception("Unknown error");
    }
  }
}