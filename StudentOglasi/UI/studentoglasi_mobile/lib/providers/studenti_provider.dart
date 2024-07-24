import 'dart:convert';
import 'package:studentoglasi_mobile/models/Student/student.dart';
import 'package:studentoglasi_mobile/providers/base_provider.dart';

class StudentiProvider extends BaseProvider<Student> {
  StudentiProvider() : super('Studenti');

  @override
  Student fromJson(data) {
    // TODO: implement fromJson
    return Student.fromJson(data);
  }

  Future<Student> getCurrentStudent() async {
    var url = "${BaseProvider.baseUrl}${endPoint}/currentStudent";
    var uri = Uri.parse(url);

    var response = await ioClient.get(uri, headers: createHeaders());

    if (isValidResponse(response)) {
      var data = jsonDecode(response.body);
      return fromJson(data);
    } else {
      throw Exception("Unknown error");
    }
  }

    Future<bool> changePassword(int id, dynamic request) async {
    var url = "${BaseProvider.baseUrl}${endPoint}/$id/change-Password";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var jsonRequest = jsonEncode(request, toEncodable: myDateSerializer);
    var response =
        await ioClient.put(uri, headers: headers, body: jsonRequest);

    if (isValidResponse(response)) {
      return true;
    } else {
      return false;
    }
  }
}
