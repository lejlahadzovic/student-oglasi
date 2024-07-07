import 'package:studentoglasi_mobile/models/Organizacije/organizacije.dart';
import 'package:studentoglasi_mobile/providers/base_provider.dart';

class OrganizacijeProvider extends BaseProvider<Organizacije> {
  OrganizacijeProvider() : super('Organizacije');
 @override
  Organizacije fromJson(data) {
    // TODO: implement fromJson
    return Organizacije.fromJson(data);
  }
}
