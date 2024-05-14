import 'package:studentoglasi_admin/models/Univerzitet/univerzitet.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';

class UniverzitetiProvider extends BaseProvider<Univerzitet> {
  UniverzitetiProvider() : super('Univerziteti');
 @override
  Univerzitet fromJson(data) {
    // TODO: implement fromJson
    return Univerzitet.fromJson(data);
  }
}
