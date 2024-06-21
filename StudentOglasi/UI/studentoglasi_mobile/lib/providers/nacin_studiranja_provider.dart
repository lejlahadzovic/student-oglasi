import 'package:studentoglasi_mobile/models/NacinStudiranja/nacin_studiranja.dart';
import 'package:studentoglasi_mobile/providers/base_provider.dart';

class NacinStudiranjaProvider extends BaseProvider<NacinStudiranja> {
  NacinStudiranjaProvider() : super('NacinStudiranja');
 @override
  NacinStudiranja fromJson(data) {
    // TODO: implement fromJson
    return NacinStudiranja.fromJson(data);
  }
}
