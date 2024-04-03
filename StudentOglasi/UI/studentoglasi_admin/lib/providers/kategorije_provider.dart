import 'package:studentoglasi_admin/models/Kategorija/kategorija.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';

class KategorijaProvider extends BaseProvider<Kategorija> {
  KategorijaProvider() : super('Kategorije');

  @override
  Kategorija fromJson(data) {
    // TODO: implement fromJson
    return Kategorija.fromJson(data);
  }
}
