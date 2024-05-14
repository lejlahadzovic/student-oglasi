
import 'package:studentoglasi_admin/models/Fakultet/fakultet.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';

class FakultetiProvider extends BaseProvider<Fakultet> {
  FakultetiProvider() : super('Fakulteti');
 @override
  Fakultet fromJson(data) {
    // TODO: implement fromJson
    return Fakultet.fromJson(data);
  }
}
