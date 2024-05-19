import 'package:studentoglasi_admin/models/StatusPrijave/statusprijave.dart';
import 'package:studentoglasi_admin/providers/base_provider.dart';

class StatusPrijaveProvider extends BaseProvider<StatusPrijave> {
  StatusPrijaveProvider() : super('StatusPrijave');
 @override
  StatusPrijave fromJson(data) {
    // TODO: implement fromJson
    return StatusPrijave.fromJson(data);
  }
}
