import 'package:studentoglasi_mobile/models/Student/student.dart';
import 'package:studentoglasi_mobile/providers/base_provider.dart';

class StudentiProvider extends BaseProvider<Student> {
  StudentiProvider() : super('Studenti');

  @override
  Student fromJson(data) {
    // TODO: implement fromJson
    return Student.fromJson(data);
  }

}
