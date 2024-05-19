import 'package:studentoglasi_admin/models/PrijaveStipendija/prijave_stipendija.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';

class PrijaveStipendijaProvider extends BaseProvider<PrijaveStipendija> {
  PrijaveStipendijaProvider() : super('PrijaveStipendija');
 @override
  PrijaveStipendija fromJson(data) {
    // TODO: implement fromJson
    return PrijaveStipendija.fromJson(data);
  }
}
