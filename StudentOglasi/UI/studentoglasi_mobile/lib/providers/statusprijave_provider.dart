import 'package:studentoglasi_mobile/providers/base_provider.dart';
import 'package:studentoglasi_mobile/models/StatusPrijave/statusprijave.dart';

class StatusPrijaveProvider extends BaseProvider<StatusPrijave> {
  StatusPrijaveProvider() : super('StatusPrijave');
 @override
  StatusPrijave fromJson(data) {
    // TODO: implement fromJson
    return StatusPrijave.fromJson(data);
  }
}
