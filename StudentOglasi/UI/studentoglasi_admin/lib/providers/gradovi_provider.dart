import 'package:studentoglasi_admin/models/Grad/grad.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';

class GradoviProvider extends BaseProvider<Grad> {
  GradoviProvider() : super('Gradovi');
 @override
  Grad fromJson(data) {
    // TODO: implement fromJson
    return Grad.fromJson(data);
  }
}
