import 'package:json_annotation/json_annotation.dart';

part 'obavijesti.g.dart';

@JsonSerializable()
class Obavijesti {
  int? id;
  int? oglasId;
  int? smjestajId;
  String? naziv;
  String? opis;
  DateTime? datumKreiranja;

  Obavijesti( this.id, this.oglasId, this.smjestajId,this.naziv, this.opis, this.datumKreiranja);

  factory Obavijesti.fromJson(Map<String, dynamic> json) => _$ObavijestiFromJson(json);

  Map<String, dynamic> toJson() => _$ObavijestiToJson(this);
}
