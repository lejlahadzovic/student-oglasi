import 'package:studentoglasi_mobile/models/Obavijesti/obavijesti.dart';
import 'base_provider.dart';

class ObavijestiProvider extends BaseProvider<Obavijesti> {
  ObavijestiProvider() : super('Obavijesti');

  @override
  Obavijesti fromJson(data) {
    // TODO: implement fromJson
    return Obavijesti.fromJson(data);
  }

}
