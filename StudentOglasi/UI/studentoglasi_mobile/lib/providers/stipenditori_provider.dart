import 'package:studentoglasi_mobile/models/Stipenditor/stipenditor.dart';
import 'package:studentoglasi_mobile/providers/base_provider.dart';

class StipenditoriProvider extends BaseProvider<Stipenditor> {
  StipenditoriProvider() : super('Stipenditori');
 @override
  Stipenditor fromJson(data) {
    // TODO: implement fromJson
    return Stipenditor.fromJson(data);
  }
}
