
import 'package:json_annotation/json_annotation.dart';

part 'statusoglasi.g.dart';

@JsonSerializable()
class StatusOglasi {
  int? id;
  String? naziv;
  String? opis;


  StatusOglasi(this.id, this.naziv, this.opis);
  factory StatusOglasi.fromJson(Map<String, dynamic> json) => _$StatusOglasiFromJson(json);

  Map<String, dynamic> toJson() => _$StatusOglasiToJson(this);
}
