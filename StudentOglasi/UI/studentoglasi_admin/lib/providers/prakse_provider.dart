import 'package:studentoglasi_admin/models/Praksa/praksa.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';

class PraksaProvider extends BaseProvider<Praksa> {
  PraksaProvider() : super('Prakse');
 @override
  Praksa fromJson(data) {
    // TODO: implement fromJson
    return Praksa.fromJson(data);
  }

}
