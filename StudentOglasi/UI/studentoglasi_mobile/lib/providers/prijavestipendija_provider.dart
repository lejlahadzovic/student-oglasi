import 'package:studentoglasi_mobile/models/PrijavaStipendija/prijave_stipendija.dart';
import 'package:studentoglasi_mobile/providers/base_provider.dart';

class PrijaveStipendijaProvider extends BaseProvider<PrijaveStipendija> {
  PrijaveStipendijaProvider() : super('PrijaveStipendija');
 @override
  PrijaveStipendija fromJson(data) {
    // TODO: implement fromJson
    return PrijaveStipendija.fromJson(data);
  }
}
