import 'package:studentoglasi_mobile/models/Univerzitet/univerzitet.dart';
import 'package:studentoglasi_mobile/providers/base_provider.dart';

class UniverzitetiProvider extends BaseProvider<Univerzitet> {
  UniverzitetiProvider() : super('Univerziteti');
 @override
  Univerzitet fromJson(data) {
    // TODO: implement fromJson
    return Univerzitet.fromJson(data);
  }
}
