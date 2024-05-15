import 'package:studentoglasi_admin/models/SmjestajnaJedinica/smjestajna_jedinica.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';

class SmjestajnaJedinicaProvider extends BaseProvider<SmjestajnaJedinica> {
  SmjestajnaJedinicaProvider() : super('SmjestajneJedinice');
 @override
  SmjestajnaJedinica fromJson(data) {
    // TODO: implement fromJson
    return SmjestajnaJedinica.fromJson(data);
  }
}
