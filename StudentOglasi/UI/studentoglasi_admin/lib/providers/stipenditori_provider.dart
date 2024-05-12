import 'package:studentoglasi_admin/models/Stipenditor/stipenditor.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';

class StipenditoriProvider extends BaseProvider<Stipenditor> {
  StipenditoriProvider() : super('Stipenditori');
 @override
  Stipenditor fromJson(data) {
    // TODO: implement fromJson
    return Stipenditor.fromJson(data);
  }
}
