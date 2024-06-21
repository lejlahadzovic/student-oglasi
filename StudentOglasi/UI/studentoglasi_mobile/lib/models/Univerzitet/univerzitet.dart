import 'package:json_annotation/json_annotation.dart';
import 'package:studentoglasi_mobile/models/Fakultet/fakultet.dart';

part 'univerzitet.g.dart';

@JsonSerializable()
class Univerzitet {
  int? id;
  String? naziv;
  List<Fakultet>? fakultetis;

  Univerzitet(this.id, this.naziv, this.fakultetis);

  factory Univerzitet.fromJson(Map<String, dynamic> json) =>
      _$UniverzitetFromJson(json);

  Map<String, dynamic> toJson() => _$UniverzitetToJson(this);
}
