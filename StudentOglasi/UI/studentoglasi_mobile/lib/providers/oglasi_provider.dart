import 'package:studentoglasi_mobile/models/Oglas/oglas.dart';
import 'package:studentoglasi_mobile/providers/base_provider.dart';

class OglasiProvider extends BaseProvider<Oglas> {
  OglasiProvider() : super('Oglasi');
 @override
  Oglas fromJson(data) {
    // TODO: implement fromJson
    return Oglas.fromJson(data);
  }
}
