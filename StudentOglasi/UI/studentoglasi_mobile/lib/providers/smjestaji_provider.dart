import 'package:studentoglasi_mobile/models/Smjestaj/smjestaj.dart';
import 'package:studentoglasi_mobile/providers/base_provider.dart';

class SmjestajiProvider extends BaseProvider<Smjestaj> {
  SmjestajiProvider() : super('Smjestaji');
 @override
  Smjestaj fromJson(data) {
    // TODO: implement fromJson
    return Smjestaj.fromJson(data);
  }
}
