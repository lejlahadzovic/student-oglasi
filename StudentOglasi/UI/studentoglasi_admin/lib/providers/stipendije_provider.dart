import 'package:studentoglasi_admin/models/Stipendija/stipendija.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';

class StipendijeProvider extends BaseProvider<Stipendije> {
  StipendijeProvider() : super('Stipendije');
 @override
  Stipendije fromJson(data) {
    // TODO: implement fromJson
    return Stipendije.fromJson(data);
  }
}
