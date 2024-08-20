
import 'package:json_annotation/json_annotation.dart';

part 'statusprijave.g.dart';

@JsonSerializable()
class StatusPrijave {
  int? id;
  String? naziv;
  String? opis;


  StatusPrijave(this.id, this.naziv, this.opis);
  factory StatusPrijave.fromJson(Map<String, dynamic> json) => _$StatusPrijaveFromJson(json);

  Map<String, dynamic> toJson() => _$StatusPrijaveToJson(this);
}
