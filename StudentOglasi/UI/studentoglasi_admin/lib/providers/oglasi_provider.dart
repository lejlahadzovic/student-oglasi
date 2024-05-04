import 'package:studentoglasi_admin/models/Oglas/oglas.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';

class OglasiProvider extends BaseProvider<Oglas> {
  OglasiProvider() : super('Oglasi');
 @override
  Oglas fromJson(data) {
    // TODO: implement fromJson
    return Oglas.fromJson(data);
  }
}
