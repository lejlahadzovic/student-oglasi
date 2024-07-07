import 'package:studentoglasi_mobile/models/Stipendija/stipendija.dart';
import 'package:studentoglasi_mobile/providers/base_provider.dart';

class StipendijeProvider extends BaseProvider<Stipendije> {
  StipendijeProvider() : super('Stipendije');
 @override
  Stipendije fromJson(data) {
    // TODO: implement fromJson
    return Stipendije.fromJson(data);
  }
}
