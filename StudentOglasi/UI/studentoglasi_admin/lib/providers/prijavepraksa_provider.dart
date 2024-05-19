import 'package:studentoglasi_admin/providers/base_provider.dart';
import '../models/PrijavePraksa/prijave_praksa.dart';

class PrijavePraksaProvider extends BaseProvider<PrijavePraksa> {
  PrijavePraksaProvider() : super('PrijavePraksa');
 @override
  PrijavePraksa fromJson(data) {
    // TODO: implement fromJson
    return PrijavePraksa.fromJson(data);
  }
}