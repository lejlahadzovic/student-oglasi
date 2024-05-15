import 'package:studentoglasi_admin/models/Smjestaj/smjestaj.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';

class SmjestajiProvider extends BaseProvider<Smjestaj> {
  SmjestajiProvider() : super('Smjestaji');
 @override
  Smjestaj fromJson(data) {
    // TODO: implement fromJson
    return Smjestaj.fromJson(data);
  }
}
