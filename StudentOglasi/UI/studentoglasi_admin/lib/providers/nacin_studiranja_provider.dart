import 'package:studentoglasi_admin/models/NacinStudiranja/nacin_studiranja.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';

class NacinStudiranjaProvider extends BaseProvider<NacinStudiranja> {
  NacinStudiranjaProvider() : super('NacinStudiranja');
 @override
  NacinStudiranja fromJson(data) {
    // TODO: implement fromJson
    return NacinStudiranja.fromJson(data);
  }
}
