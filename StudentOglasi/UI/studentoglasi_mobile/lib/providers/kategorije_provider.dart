import '../models/Kategorija/kategorija.dart';
import 'base_provider.dart';

class KategorijaProvider extends BaseProvider<Kategorija> {
  KategorijaProvider() : super('Kategorije');

  @override
  Kategorija fromJson(data) {
    // TODO: implement fromJson
    return Kategorija.fromJson(data);
  }
}
