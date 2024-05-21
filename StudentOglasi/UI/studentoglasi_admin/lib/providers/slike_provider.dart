import 'package:studentoglasi_admin/models/Slike/slike.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';

class SlikeProvider extends BaseProvider<Slike> {
  SlikeProvider() : super('Slike');
 @override
  Slike fromJson(data) {
    // TODO: implement fromJson
    return Slike.fromJson(data);
  }
}
