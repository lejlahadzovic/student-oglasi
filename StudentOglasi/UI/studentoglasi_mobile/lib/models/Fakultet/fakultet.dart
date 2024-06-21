import 'package:json_annotation/json_annotation.dart';
import 'package:studentoglasi_mobile/models/Smjer/smjer.dart';

part 'fakultet.g.dart';

@JsonSerializable()
class Fakultet {
  int? id;
  String? naziv;
  List<Smjer>? smjerovi;
  int? univerzitetId;

  Fakultet(this.id, this.naziv, this.smjerovi);

  factory Fakultet.fromJson(Map<String, dynamic> json) =>
      _$FakultetFromJson(json);

  Map<String, dynamic> toJson() => _$FakultetToJson(this);
}
