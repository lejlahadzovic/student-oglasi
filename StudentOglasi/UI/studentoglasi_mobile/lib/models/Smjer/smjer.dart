import 'package:json_annotation/json_annotation.dart';

part 'smjer.g.dart';

@JsonSerializable()
class Smjer {
  int? id;
  String? naziv;
  String? opis;

  Smjer(this.id, this.naziv, this.opis);

  factory Smjer.fromJson(Map<String, dynamic> json) => _$SmjerFromJson(json);

  Map<String, dynamic> toJson() => _$SmjerToJson(this);
}
