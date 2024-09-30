import 'package:studentoglasi_admin/models/Student/student.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';
import 'package:http/http.dart' as http;

class StudentiProvider extends BaseProvider<Student> {
  StudentiProvider() : super('Studenti');

  @override
  Student fromJson(data) {
    // TODO: implement fromJson
    return Student.fromJson(data);
  }

  Future<bool> isUsernameTaken(String username) async {
    var url = "${baseUrl}${endPoint}/check-username/$username";
    var uri = Uri.parse(url);
    var headers = createHeaders();

    var response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      return false;
    } else {
      return true;
    }
  }
}
