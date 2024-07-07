import 'package:studentoglasi_mobile/models/StatusOglas/statusoglasi.dart';
import 'package:studentoglasi_mobile/providers/base_provider.dart';

class StatusOglasiProvider extends BaseProvider<StatusOglasi> {
  StatusOglasiProvider() : super('StatusOglasi');
 @override
  StatusOglasi fromJson(data) {
    // TODO: implement fromJson
    return StatusOglasi.fromJson(data);
  }
}
