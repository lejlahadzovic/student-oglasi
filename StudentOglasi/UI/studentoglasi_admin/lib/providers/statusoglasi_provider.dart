import 'package:studentoglasi_admin/models/StatusOglasi/statusoglasi.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';

class StatusOglasiProvider extends BaseProvider<StatusOglasi> {
  StatusOglasiProvider() : super('StatusOglasi');
 @override
  StatusOglasi fromJson(data) {
    // TODO: implement fromJson
    return StatusOglasi.fromJson(data);
  }
}
