import '../models/Objava/objava.dart';
import 'base_provider.dart';

class ObjaveProvider extends BaseProvider<Objava> {
  ObjaveProvider() : super('Objave');

  @override
  Objava fromJson(data) {
    // TODO: implement fromJson
    return Objava.fromJson(data);
  }

}
