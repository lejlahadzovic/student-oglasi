import 'package:studentoglasi_admin/models/Rezervacije/rezervacije.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';

class RezervacijeProvider extends BaseProvider<Rezervacije> {
  RezervacijeProvider() : super('Rezervacije');
 @override
  Rezervacije fromJson(data) {
    // TODO: implement fromJson
    return Rezervacije.fromJson(data);
  }
}